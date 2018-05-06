﻿<%@ WebHandler Language="C#" Class="Complete" %>

using System.Web;
using Budong.Common.Utils;

public class Complete : IHttpHandler {

    public void ProcessRequest(HttpContext context)
    {
        //  格式化参数
        int missionId = Parse.ToInt(context.Request.Params["missionId"]);
        string session3rd = context.Request.Params["session3rd"];

        //  定义返回结果
        Hash result = ClientService.Token(session3rd);

        if (result.ToInt("code") == 0)
        {
            result = MissionGameService.Complete(result.ToHash("data"), missionId);
        }

        //  记录日志
        ClientService.Log(session3rd);

        //  返回结果
        context.Response.Write(result.ToJSON());
    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}