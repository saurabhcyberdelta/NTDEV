using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;

/// <summary>
/// Summary description for MyPageSession
/// </summary>
public class MyPageSession
{
	public MyPageSession()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    # region Private Constants
    //---------------------------------------------------------------------
    private const string sDate = "sDate";
    private const string Facility = "Facility";
    private const string TripType = "TripType";
    private const string Shift = "Shift";
    private const string NoOfSheets = "NoOfSheets";
    private const string Action = "Action";
    private const string EmpDataTable = "EmpDataTable";
    private const string CabType = "CabType";
    private const string Remarks = "Remarks";
    private const string transaction = "transaction";

    //---------------------------------------------------------------------
    # endregion

    # region Public Properties
    
    /// <summary>
    ///     StartDate is the earliest date used to filter records.
    /// </summary>
    public static string _sDate
    {
        get
        {
            if (HttpContext.Current.Session[sDate] == null)
                return "";
            else
                return (string)HttpContext.Current.Session[sDate];
        }

        set
        {
            HttpContext.Current.Session[sDate] = value;
        }
    }


    /// <summary>
    ///     Facility is the earliest date used to filter records.
    /// </summary>
    public static Int32 _Facility
    {
        get
        {
            if (HttpContext.Current.Session[Facility] == null)
                return 0;
            else
                return (Int32)HttpContext.Current.Session[Facility];
        }

        set
        {
            HttpContext.Current.Session[Facility] = value;
        }
    }

    /// <summary>
    ///     TripType is the earliest date used to filter records.
    /// </summary>
    public static string _TripType
    {
        get
        {
            if (HttpContext.Current.Session[TripType] == null)
                return "";
            else
                return (string)HttpContext.Current.Session[TripType];
        }

        set
        {
            HttpContext.Current.Session[TripType] = value;
        }
    }

    /// <summary>
    ///     Shift is the earliest date used to filter records.
    /// </summary>
    public static string _Shift
    {
        get
        {
            if (HttpContext.Current.Session[Shift] == null)
                return "";
            else
                return (string)HttpContext.Current.Session[Shift];
        }

        set
        {
            HttpContext.Current.Session[Shift] = value;
        }
    }

    /// <summary>
    ///     NoOfSheets is the earliest date used to filter records.
    /// </summary>
    public static Int32 _NoOfSheets
    {
        get
        {
            if (HttpContext.Current.Session[NoOfSheets] == null)
                return 0;
            else
                return (Int32)HttpContext.Current.Session[NoOfSheets];
        }

        set
        {
            HttpContext.Current.Session[NoOfSheets] = value;
        }
    }

    /// <summary>
    ///     Action is the earliest date used to filter records.
    /// </summary>
    public static string _Action
    {
        get
        {
            if (HttpContext.Current.Session[Action] == null)
                return "";
            else
                return (string)HttpContext.Current.Session[Action];
        }

        set
        {
            HttpContext.Current.Session[Action] = value;
        }
    }

    /// <summary>
    ///     Action is the earliest date used to filter records.
    /// </summary>
    public static DataTable _EmpDataTable
    {
        get
        {
            if (HttpContext.Current.Session[EmpDataTable] == null)
                return null;
            else
                return (DataTable)HttpContext.Current.Session[EmpDataTable];
        }

        set
        {
            HttpContext.Current.Session[EmpDataTable] = value;
        }
    }

    /// <summary>
    ///     Action is the earliest date used to filter records.
    /// </summary>
    public static string _CabType
    {
        get
        {
            if (HttpContext.Current.Session[CabType] == null)
                return "";
            else
                return (string)HttpContext.Current.Session[CabType];
        }

        set
        {
            HttpContext.Current.Session[CabType] = value;
        }
    }
    public static string _Remarks
    {
        get
        {
            if (HttpContext.Current.Session[Remarks] == null)
                return "";
            else
                return (string)HttpContext.Current.Session[Remarks];
        }

        set
        {
            HttpContext.Current.Session[Remarks] = value;
        }
    }
    public static string _transaction
    {
        get
        {
            if (HttpContext.Current.Session[transaction] == null)
                return "";
            else
                return (string)HttpContext.Current.Session[transaction];
        }

        set
        {
            HttpContext.Current.Session[transaction] = value;
        }
    }
    # endregion
}
