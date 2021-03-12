function main() {
	// Module Foo does not define type Foo
	"" is Foo.Bar;

	// compiles
	Std.isOfType("", Foo.Bar);
}
