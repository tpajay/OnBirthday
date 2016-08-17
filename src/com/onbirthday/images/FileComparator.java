package com.onbirthday.images;

import java.util.Comparator;
import com.onbirthday.images.*;

public class FileComparator
    implements Comparator
{

    public FileComparator(String s)
    {
        howTo = s;
    }

    public int compare(Object obj, Object obj1)
    {
        FileBean filebean = (FileBean)obj;
        FileBean filebean1 = (FileBean)obj1;
        if(howTo.equals("1"))
            return filebean.getName().compareTo(filebean1.getName());
        if(howTo.equals("2"))
        {
            long l = filebean.getTime();
            long l1 = filebean1.getTime();
            if(l == l1)
                return 0;
            return l1 <= l ? -1 : 1;
        } else
        {
            return 0;
        }
    }

    private String howTo;
}
