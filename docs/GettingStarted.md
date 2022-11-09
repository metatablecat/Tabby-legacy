# Getting Started
Before going through the docs its good to learn how to set up your project so that you can develop Tabby plugins as these docs intend.

To begin with setting up the project, you'll need to know how to develop the plugin based on where you are. These docs should translate regardless of environment, but the setup process is different between the two

=== "Rojo Projects"
	Before everything else, set up a Rojo project intended for Plugin development.

	Then, there are two ways of obtaining the Tabby framework source.

	1. Download the `tabby.rbxm` binary directly and drag it into your `src` folder named `Framework`
	2. **RECOMMENDED** Use a git submodule to create a link to the repository hosted over on the GitHub repository
		```bash
		git submodule add https://github.com/metatablecat/Tabby.git src/Framework
		```
	Finally, add a folder named `Runtime` to your `src` folder, and you have successfully set up Tabby

	To build a plugin under Rojo, use the following command:
	```ps1
	# This is PowerShell syntax, change $env:localappdata to %LOCALAPPDATA% if using the classic command line on Windows
	rojo build --output $env:localappdata/Roblox/Plugins/YourPluginName.rbxm
	```

=== "Roblox Studio"
	Create a Plugin with a new folder, and drag the `tabby.rbxm` model into it, then add a second folder named `Runtime`
	!!! tip "Enable PluginDebuggingService"
		Plugin Development is a lot easier under Roblox Studio with this enabled. You can do this by navigating to Studio Settings and searching for `Enable Plugin Debugging Service`. Studio will need to restart before enabling this.

	To build plugins under Roblox Studio, you can simply right click the top folder and click *Save as Local Plugin...*

---

!!! tip
	You can name the Framework module whatever you want, however, make sure to change code examples to reflect this change

??? abstract "Code not working as intended?"

	=== "Rojo Project"
		Make sure the structure of the project is as followed

		```
		src
			Runtime
			Framework
		default.project.json
		```
	
	=== "Roblox Studio"
		Your plugin should have a folder and a module script with this structure

		```
		PluginRoot
			Runtime
			Framework
		```
	