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
		var args = ['--connect', getPort()].concat(readDisplayArgs());
		var c = Sys.command('haxe', args);
		trace('Exit code: $c');
	}

	static function getPort():String {
		var port = Compiler.getDefine('port');
		return (port == null ? '60000' : port);
	}

	static function readDisplayArgs():Array<String> {
		var rawData = 'display/args.txt'.getContent();
		rawData = rawData.substring(rawData.indexOf('[') + 1, rawData.lastIndexOf(']'));

		var jsonPos = rawData.indexOf('{');
		var args = rawData.substr(0, jsonPos).split(',');
		var display:DisplayJson = rawData.substr(jsonPos).parse();
		if (display.params != null && display.params.file != null) {
			display.params.contents = display.params.file.getContent();
		}

		return args.concat([display.stringify()]);
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
