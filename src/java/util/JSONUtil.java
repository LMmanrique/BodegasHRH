package util;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Collection;
import org.json.JSONArray;
import org.json.JSONObject;

public class JSONUtil {

    /** Envía un objeto o lista como JSON al response */
    public static void writeJson(HttpServletResponse resp, Object data) throws IOException {
        resp.setContentType("application/json;charset=UTF-8");
        PrintWriter out = resp.getWriter();

        // 1) JsonResponse -> { success: ..., message: ... }
        if (data instanceof JsonResponse) {
            JsonResponse jr = (JsonResponse) data;
            JSONObject j = new JSONObject();
            j.put("success", jr.success);
            j.put("message", jr.message);
            out.print(j.toString());
        }
        // 2) Collection -> [ {...}, {...}, ... ]
        else if (data instanceof Collection) {
            JSONArray arr = new JSONArray((Collection<?>) data);
            out.print(arr.toString());
        }
        // 3) Un POJO cualquiera -> { field1: val1, field2: val2, ... }
        else {
            JSONObject j = new JSONObject(data);
            out.print(j.toString());
        }
        out.flush();
    }

    /** Simple struct para respuestas de éxito/error */
    public static class JsonResponse {
        public boolean success;
        public String message;
        public JsonResponse() {}
        public JsonResponse(boolean success, String message) {
            this.success = success;
            this.message = message;
        }
    }
}
