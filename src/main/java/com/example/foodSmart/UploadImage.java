package com.example.foodSmart;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;

@WebServlet("/foodSmartImages/*")
public class UploadImage extends HttpServlet {

    private static final String avtars_dir = "C:\\foodSmartImages\\avatars";
    private static final String products_dir = "C:\\foodSmartImages\\product";
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String pathInfo = req.getPathInfo();
        if (pathInfo == null || pathInfo.length() <= 1) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid file path");
            return;
        }
        String[] parts = pathInfo.substring(1).split("/", 2);
        if (parts.length < 2) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid file path");
            return;
        }
        String directory = parts[0];
        String filename = parts[1];

        String baseDir;
        if ("avatars".equals(directory)) {
//            baseDir = getServletContext().getRealPath("/images/avatars");
            baseDir = avtars_dir;

        } else if ("product".equals(directory)) {
//            baseDir = getServletContext().getRealPath("/images/product");
            baseDir = products_dir;
        } else {
            resp.sendError(HttpServletResponse.SC_FORBIDDEN, "Access denied");
            return;
        }
        File file = new File(baseDir, filename);
        if (!file.exists()) {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }
        resp.setContentType(getServletContext().getMimeType(filename));
        resp.setContentLength((int) file.length());
        Files.copy(file.toPath(), resp.getOutputStream());
    }
}

