class Main {
	public static function main() {
		#if (cpp && HXCPP_DEBUGGER)
		new debugger.Local(true);
		#end

		trace("Test");
	}
}