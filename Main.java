import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.IOException;
import java.util.Arrays;

import lox.Lox;
import tool.GenerateAst;

class Main {
  public static void main(String[] args) throws IOException {
    InputStreamReader input = new InputStreamReader(System.in);
    BufferedReader reader = new BufferedReader(input);

    for (;;) {
      System.out.print("~ ");
      String ln = reader.readLine();
      if (ln == ":q") System.exit(0);
      // split input along whitespace
      String[] params = ln.split(" ");
      String[] trimmedParams = trimParams(params);
      switch (trimmedParams[0]) {
        case "jlox":
          if (trimmedParams.length == 2) {
            String arguments[];
            arguments.put(trimmedParams[1]);
            Lox.main(arguments);
            break;
          } else {
            Lox.main(new String[]);
            break;
          }
        case "generate-ast": GenerateAst.main(new String[]); break;
        //case "print-ast": AstPrinter.main(new String[]); break;
        default:
          System.out.println("Incorrect input.");
          break;
      }
    }
  }

  private static String[] trimParams(String[] args) {
    String[] params;
    for (String param : args) {
      String trimmed = param.trim();
      params.put(trimmed);
    }
    return params;
  }
}