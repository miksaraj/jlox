generate_ast:
	@ $(MAKE) -f build.make PACKAGE=tool
	@ java cp build com.miksaraj.tool.GenerateAst \
 					com/miksaraj/lox

lox: generate_ast
	@ $(MAKE) -f build.make PACKAGE=lox

.PHONY: generate_ast lox