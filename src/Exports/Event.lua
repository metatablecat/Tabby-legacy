-- Simple Event Library
-- Usage: CatMeowed = Event<boolean>()

local Types = require(script.Parent.Parent.Types)
type Signal<A...> = Types.Signal<A...>
type Event<A...> = Types.Event<A...>

local function Signal<A...>(): Signal<A...>
	local Signal = {}
	
	Signal.ConnectedFunctions = {}
	Signal.WaitingThreads = {}
	
	function Signal.Connect(self: Signal<A...>, func: (A...) -> ()): () -> ()
		local index = #self.ConnectedFunctions + 1
		self.ConnectedFunctions[index] = func

		return function()
			table.remove(self.ConnectedFunctions, index)
		end
	end

	function Signal.Wait(self: Signal<A...>): A...
		local co = coroutine.running()
		table.insert(self.WaitingThreads, co)
		return coroutine.yield(co)
	end
	
	return Signal
end

return function<A...>(): Event<A...>
	local Event = {}
	Event.Signal = Signal() :: Signal<A...>

	function Event.Fire(self: Event<A...>, ...: A...)
		local sig = self.Signal
		-- first, handoff callbacks
		-- then release threads
		-- do not rely on this order as it's an implementation detail
		for _, callback: (A...) -> () in sig.ConnectedFunctions do
			task.spawn(callback, ...)
		end

		for _, thread in sig.WaitingThreads do
			coroutine.resume(thread, ...)
		end
	end

	return Event
end