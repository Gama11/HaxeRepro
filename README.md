Empty Haxe project with a VSCode `tasks.json` for all available targets. Useful for reproducing Haxe issues.

### How to reproduce completion/compilation server issues using command line

1. Add `"haxe.displayServer.arguments": ["-v"]` to your `.vscode/settings.json`
2. Reproduce your issue in vscode
3. Copy the contents of "Output" panel to the `display/output.log` file in this (HaxeRepro) repository
![img](https://i.imgur.com/FzeF93q.png)
4. Start a server: `haxe -v --wait 60000`
5. Execute `haxe -x display.Run` from the root of this repository to automatically reproduce your issue.