package com.onbirthday.images;

import java.util.*;
import java.io.*;
import java.text.*;
import java.lang.*;

public class WebFileBean
{

    public WebFileBean()
    {
    }

    public WebFileBean(String file1)
    {
        file = file1;
    }

    public void setFile(String file1)
    {
        file = file1;
    }

    public String getName()
    {
        return file;
    }

    private String file;
}
