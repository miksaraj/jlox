generate_ast:
	@ $(MAKE) -f build.make PACKAGE=tool
	@ java cp build/tool.GenerateAst lox

lox: generate_ast
	@ $(MAKE) -f build.make PACKAGE=lox

.PHONY: generate_ast lox