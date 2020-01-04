package;

using tink.CoreApi;

@await
class Main {
	static function main() {
		new Main();
	}

	function new() {
		doStuff().handle(o -> trace(o));
	}

	var foo:Int;

	@async function doStuff() {
		foo = @await gen();
	}

	function gen():Promise<Int> {
		var t = Future.trigger();
		t.trigger(Success(42));
		return t;
	}
}
