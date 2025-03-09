package com.example.foodSmart;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;

@WebServlet("/images/*")
public class UploadImage extends HttpServlet {

    private static final String AVATAR_DIR = System.getenv("uploadPath") + File.separator + "avatars";
    private static final String PRODUCT_DIR = System.getenv("uploadPath") + File.separator + "product";

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String pathInfo = req.getPathInfo();
        if (pathInfo == null || pathInfo.length() <= 1) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid file path");
            return;
        }

        String[] parts = pathInfo.substring(1).split("/", 2);
        if (parts.length < 2) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid file path format");
            return;
        }

        String directory = parts[0];
        String filename = parts[1];

        String baseDir;
        if ("avatars".equals(directory)) {
            baseDir = AVATAR_DIR;
        } else if ("product".equals(directory)) {
            baseDir = PRODUCT_DIR;
        } else {
            resp.sendError(HttpServletResponse.SC_FORBIDDEN, "Access denied");
            return;
        }

        File file = new File(baseDir, filename);
        if (!file.exists() || !file.isFile()) {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND, "File not found");
            return;
        }

        String contentType = getServletContext().getMimeType(file.getName());
        if (contentType == null) {
            contentType = "application/octet-stream";
        }
        resp.setContentType(contentType);
        resp.setContentLengthLong(file.length());

        Files.copy(file.toPath(), resp.getOutputStream());
    }
}
