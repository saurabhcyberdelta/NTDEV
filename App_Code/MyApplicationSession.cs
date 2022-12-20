using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.IO ;


/// <summary>
/// Summary description for MyApplicationSession
/// </summary>
public static class MyApplicationSession
{
    	
    # region Private Constants
    //---------------------------------------------------------------------
    private const string UserName = "UserName";
    private const string empName = "empName";
    private const string UserID = "UserID";
    private const string FacilityID = "FacilityID";
    private const string LocationId = "LocationId";
    private const string LoggedInTime = "LoggedInTime";
    private const string ISAdmin = "ISAdmin";
    private const string CurrSessionID = "CurrSessionID";
    private const string IsExceptional = "IsExceptional";
    
    //---------------------------------------------------------------------
    # endregion

    # region Public Properties
    //---------------------------------------------------------------------
    /// <summary>
    ///     The Username is the domain name and username of the current user.
    /// </summary>
    public static string LoginUser
    {

        get { return HttpContext.Current.Request.ServerVariables["LOGON_USER"]; }
    }


    /// <summary>
    ///     StartDate is the earliest date used to filter records.
    /// </summary>
    public static string _UserName
    {
        get
        {
            if (HttpContext.Current.Session[UserName] == null)
                return "No-User";
            else
                return (string)HttpContext.Current.Session[UserName];
        }

        set
        {
            HttpContext.Current.Session[UserName] = value;
        }
    }

    /// <summary>
    ///     StartDate is the earliest date used to filter records.
    /// </summary>
    public static Int32 _UserID
    {
        get
        {
            if (HttpContext.Current.Session[UserID] == null)
                return 0;
            else
                return (Int32)HttpContext.Current.Session[UserID];
        }

        set
        {
            HttpContext.Current.Session[UserID] = value;
        }
    }

    /// <summary>
    ///     StartDate is the earliest date used to filter records.
    /// </summary>
    public static string _empName
    {
        get
        {
            if (HttpContext.Current.Session[empName] == null)
                return "No empName return";
            else
                return (string)HttpContext.Current.Session[empName];
        }

        set
        {
            HttpContext.Current.Session[empName] = value;
        }
    }

    /// <summary>
    ///     StartDate is the earliest date used to filter records.
    /// </summary>
    public static Int32 _FacilityID
    {
        get
        {
            if (HttpContext.Current.Session[FacilityID] == null)
                return 0;
            else
                return (Int32)HttpContext.Current.Session[FacilityID];
        }

        set
        {
            HttpContext.Current.Session[FacilityID] = value;
        }
    }

    /// <summary>
    ///     StartDate is the earliest date used to filter records.
    /// </summary>
    public static Int32 _LocationId
    {
        get
        {
            if (HttpContext.Current.Session[LocationId] == null)
                return 0;
            else
                return (Int32)HttpContext.Current.Session[LocationId];
        }

        set
        {
            HttpContext.Current.Session[LocationId] = value;
        }
    }

    /// <summary>
    ///     StartDate is the earliest date used to filter records.
    /// </summary>
    public static string _LoggedInTime
    {
        get
        {
            if (HttpContext.Current.Session[LoggedInTime] == null)
                return "";
            else
                return (string)HttpContext.Current.Session[LoggedInTime];
        }

        set
        {
            HttpContext.Current.Session[LoggedInTime] = value;
        }
    }

    /// <summary>
    ///     StartDate is the earliest date used to filter records.
    /// </summary>
    public static Boolean _ISAdmin
    {
        get
        {
            if (HttpContext.Current.Session[ISAdmin] == null)
                return false;
            else
                return (Boolean)HttpContext.Current.Session[ISAdmin];
        }

        set
        {
            HttpContext.Current.Session[ISAdmin] = value;
        }
    }

    //---------------------------------------------------------------------
    /// <summary>
    ///     get current sessionid
    /// </summary>
    public static string _CurrSessionID
    {
        get
        {
            if (HttpContext.Current.Session[CurrSessionID] == null)
                return "No-sessionID";
            else
                return (string)HttpContext.Current.Session[CurrSessionID];
        }

        set
        {
            HttpContext.Current.Session[CurrSessionID] = value;
        }
    }
    public static string _IsExceptional
    {
        get
        {
            if (HttpContext.Current.Session[IsExceptional] == null)
                return "No-sessionID";
            else
                return (string)HttpContext.Current.Session[IsExceptional];
        }

        set
        {
            HttpContext.Current.Session[IsExceptional] = value;
        }
    }

    //---------------------------------------------------------------------
    # endregion
}
