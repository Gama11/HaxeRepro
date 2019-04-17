package display;

import haxe.macro.Compiler;

using sys.io.File;
using haxe.Json;

/**
 * Run with `haxe -x display.Run -D port=XXXXX` from the root of HaxeRepro.
 * Port is used as an argument for `--connect XXXXX`.
 * Default port is 60000.
 */
class Run {
	static public function main() {
		var connectArgs = ['--connect', getPort()];
		var i = 0;
		for (displayArgs in readDisplayArgs()) {
			Sys.println('|> Executing ${++i} line of display/args.txt...');
			Sys.command('haxe', connectArgs.concat(displayArgs));
		}
		Sys.println('|> Done.');
	}

	static function getPort():String {
		var port = Compiler.getDefine('port');
		return (port == null ? '60000' : port);
	}

	static function readDisplayArgs():Array<Array<String>> {
		var result = [];
		for (rawData in 'display/args.txt'.getContent().split('\n')) {
			rawData = rawData.substring(rawData.indexOf('[') + 1, rawData.lastIndexOf(']'));

			var jsonPos = rawData.indexOf('{');
			if (jsonPos == -1) {
				result.push(rawData.split(','));
			} else {
				var args = rawData.substr(0, jsonPos).split(',');
				var display:DisplayJson = rawData.substr(jsonPos).parse();
				if (display.params != null && display.params.file != null) {
					display.params.contents = display.params.file.getContent();
				}
				result.push(args.concat([display.stringify()]));
			}
		}
		return result;
	}
}

typedef DisplayJson = {
	jsonrpc:String,
	id:Int,
	method:String,
	?params:{
		?file:String,
		?contents:String,
		?offset:Int
	}
}
