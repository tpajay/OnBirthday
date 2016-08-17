package com.onbirthday.images;

import java.io.File;

public class FileBean
{

    public FileBean()
    {
    }

    public FileBean(File file1)
    {
        file = file1;
    }

    public void setFile(File file1)
    {
        file = file1;
    }

    public String getName()
    {
        return file.getName();
    }

    public long getTime()
    {
        return file.lastModified();
    }

    private File file;
}
