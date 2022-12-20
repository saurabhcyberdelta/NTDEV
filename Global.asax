﻿<%@ Application Language="C#" %>

<script runat="server">

    void Application_Start(object sender, EventArgs e) 
    {
        // Code that runs on application startup

    }
    
    void Application_End(object sender, EventArgs e) 
    {
        //  Code that runs on application shutdown

    }
        
    void Application_Error(object sender, EventArgs e) 
    { 
        // Code that runs when an unhandled error occurs
        Exception exc = Server.GetLastError();

        // Handle HTTP errors
        if (exc.GetType() == typeof(HttpException))
        {
            // The Complete Error Handling Example generates
            // some errors using URLs with "NoCatch" in them;
            // ignore these here to simulate what would happen
            // if a global.asax handler were not implemented.
            if (exc.Message.Contains("NoCatch"))
                return;

            //Redirect HTTP errors to HttpError page
            Server.Transfer("HttpErrorPage.aspx");
        }

        // For other kinds of errors give the user some information
        // but stay on the default page
        Response.Write("<h2>Application Error</h2>\n");
        Response.Write("<p>We're sorry, but an unhandled error occurred on the server. The Server Administrator has been notified and the error has been logged.</p>\n");
        Response.Write("Return to the <a href='Default.aspx'>" + "Home Page</a>\n");

        // Log the exception and notify system operators
        ExceptionUtility.LogException(exc, "Application Page Error");

        // Clear the error from the server
        Server.ClearError();
    }

    void Session_Start(object sender, EventArgs e) 
    {
        // Code that runs when a new session is started

    }

    void Session_End(object sender, EventArgs e) 
    {
        // Code that runs when a session ends. 
        // Note: The Session_End event is raised only when the sessionstate mode
        // is set to InProc in the Web.config file. If session mode is set to StateServer 
        // or SQLServer, the event is not raised.

    }
       
</script>
