﻿<%@ WebHandler Language="C#" Class="Help" %>

using System.Web;
using Budong.Common.Utils;

public class Help : IHttpHandler {

    public void ProcessRequest(HttpContext context)
    {
        //  格式化参数
        int subjectId = Parse.ToInt(context.Request.Params["subjectId"]);
        int missionId = Parse.ToInt(context.Request.Params["missionId"]);
        int fromClientId = Parse.ToInt(context.Request.Params["fromClientId"]);
        string session3rd = context.Request.Params["session3rd"];

        //  定义返回结果
        Hash result = ClientService.Token(session3rd);

        if (result.ToInt("code") == 0)
        {
            result = MissionGameService.Help(result.ToHash("data"), missionId, subjectId, fromClientId);
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