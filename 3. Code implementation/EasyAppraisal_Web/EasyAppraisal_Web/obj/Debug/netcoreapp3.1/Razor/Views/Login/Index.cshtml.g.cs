#pragma checksum "C:\ETAG\WEK\MyOwn\.Net Core\Easy Appraisal\3. Code implementation\EasyAppraisal_Web\EasyAppraisal_Web\Views\Login\Index.cshtml" "{ff1816ec-aa5e-4d10-87f7-6f4963833460}" "4e22abbd82dc4f3f8341317795281cb2d36c5398"
// <auto-generated/>
#pragma warning disable 1591
[assembly: global::Microsoft.AspNetCore.Razor.Hosting.RazorCompiledItemAttribute(typeof(AspNetCore.Views_Login_Index), @"mvc.1.0.view", @"/Views/Login/Index.cshtml")]
namespace AspNetCore
{
    #line hidden
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Threading.Tasks;
    using Microsoft.AspNetCore.Mvc;
    using Microsoft.AspNetCore.Mvc.Rendering;
    using Microsoft.AspNetCore.Mvc.ViewFeatures;
#nullable restore
#line 1 "C:\ETAG\WEK\MyOwn\.Net Core\Easy Appraisal\3. Code implementation\EasyAppraisal_Web\EasyAppraisal_Web\Views\_ViewImports.cshtml"
using EasyAppraisal_Web;

#line default
#line hidden
#nullable disable
#nullable restore
#line 2 "C:\ETAG\WEK\MyOwn\.Net Core\Easy Appraisal\3. Code implementation\EasyAppraisal_Web\EasyAppraisal_Web\Views\_ViewImports.cshtml"
using EasyAppraisal_Web.Models;

#line default
#line hidden
#nullable disable
    [global::Microsoft.AspNetCore.Razor.Hosting.RazorSourceChecksumAttribute(@"SHA1", @"4e22abbd82dc4f3f8341317795281cb2d36c5398", @"/Views/Login/Index.cshtml")]
    [global::Microsoft.AspNetCore.Razor.Hosting.RazorSourceChecksumAttribute(@"SHA1", @"9c45d0118a93d83d7402442738dc2c35f325b672", @"/Views/_ViewImports.cshtml")]
    public class Views_Login_Index : global::Microsoft.AspNetCore.Mvc.Razor.RazorPage<dynamic>
    {
        #pragma warning disable 1998
        public async override global::System.Threading.Tasks.Task ExecuteAsync()
        {
#nullable restore
#line 1 "C:\ETAG\WEK\MyOwn\.Net Core\Easy Appraisal\3. Code implementation\EasyAppraisal_Web\EasyAppraisal_Web\Views\Login\Index.cshtml"
      
    ViewData["Title"] = "Login Page";
    Layout = "~/Views/Shared/_LoginLayout.cshtml";

#line default
#line hidden
#nullable disable
            WriteLiteral(@"
<p style=""padding-top: 150px;text-align:center;font-size:x-large"">Easy Appraisal</p>

<div class=""row"">
    <div class=""col-4""></div>
    <div class=""col-4"">
        <div class=""row"">
            <input type=""text"" class=""form-control"" id=""userCode"" placeholder=""Enter User Code"">
        </div>
    </div>
</div>
<br />
<div class=""row"">
    <div class=""col-4""></div>
    <div class=""col-4"">
        <div class=""row"">
            <input type=""password"" class=""form-control"" id=""password"" placeholder=""Enter Password"">
        </div>
    </div>
</div>
<br />
<div class=""row"">
    <div class=""col-4""></div>
    <div class=""col-4"">
        <div class=""row"">
            <button type=""button"" class=""btn btn-dark"" style=""width:100%"" onclick=""Login()"">Login</button>
        </div>
    </div>
</div>

<script>
    function Login()
    {
        var userCode = $(""#userCode"").val().trim();
        var password = $(""#password"").val().trim();
        var errorMsg = """";
        if (userCode.l");
            WriteLiteral(@"ength == 0)
            errorMsg += ""User Code is required \r\n"";
        if (password.length == 0)
            errorMsg += ""Password is required"";

        if (errorMsg != """")
            alert(errorMsg);
        else {
            var userData = {
                'UserCode': userCode,
                'Password': password
            };
            $.ajax({
                url: 'https://localhost:44341/api/login/login',
                type: 'POST',
                data: userData,
                dataType: 'json',
                success: function (result) {
                    if (result.responseCode == 0) {
                        if (result.responseMessage == ""Manager"")
                            window.location.href = """);
#nullable restore
#line 61 "C:\ETAG\WEK\MyOwn\.Net Core\Easy Appraisal\3. Code implementation\EasyAppraisal_Web\EasyAppraisal_Web\Views\Login\Index.cshtml"
                                               Write(Url.Action("Index", "HomeForManager", new { userCode = -1 } ));

#line default
#line hidden
#nullable disable
            WriteLiteral("\".replace(\"-1\", userCode);\r\n                        else\r\n                            window.location.href = \"");
#nullable restore
#line 63 "C:\ETAG\WEK\MyOwn\.Net Core\Easy Appraisal\3. Code implementation\EasyAppraisal_Web\EasyAppraisal_Web\Views\Login\Index.cshtml"
                                               Write(Url.Action("Index", "Home", new { userCode = -1 } ));

#line default
#line hidden
#nullable disable
            WriteLiteral("\".replace(\"-1\", userCode);\r\n                    }\r\n                    else\r\n                        alert(result.responseMessage);\r\n                }\r\n            });\r\n        }\r\n    }\r\n</script>");
        }
        #pragma warning restore 1998
        [global::Microsoft.AspNetCore.Mvc.Razor.Internal.RazorInjectAttribute]
        public global::Microsoft.AspNetCore.Mvc.ViewFeatures.IModelExpressionProvider ModelExpressionProvider { get; private set; }
        [global::Microsoft.AspNetCore.Mvc.Razor.Internal.RazorInjectAttribute]
        public global::Microsoft.AspNetCore.Mvc.IUrlHelper Url { get; private set; }
        [global::Microsoft.AspNetCore.Mvc.Razor.Internal.RazorInjectAttribute]
        public global::Microsoft.AspNetCore.Mvc.IViewComponentHelper Component { get; private set; }
        [global::Microsoft.AspNetCore.Mvc.Razor.Internal.RazorInjectAttribute]
        public global::Microsoft.AspNetCore.Mvc.Rendering.IJsonHelper Json { get; private set; }
        [global::Microsoft.AspNetCore.Mvc.Razor.Internal.RazorInjectAttribute]
        public global::Microsoft.AspNetCore.Mvc.Rendering.IHtmlHelper<dynamic> Html { get; private set; }
    }
}
#pragma warning restore 1591
