themes/snorlax/login/template.ftl

<#macro registrationLayout bodyClass="" displayInfo=false displayMessage=true displayRequiredFields=false>
<!DOCTYPE html>
<html class="${properties.kcHtmlClass!}">

<head>
    <meta charset="utf-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="robots" content="noindex, nofollow">

    <#if properties.meta?has_content>
        <#list properties.meta?split(' ') as meta>
            <meta name="${meta?split('==')[0]}" content="${meta?split('==')[1]}"/>
        </#list>
    </#if>
    <title>${msg("loginTitle",(realm.displayName!''))}</title>
    <link rel="icon" href="${url.resourcesPath}/img/favicon.ico" />
    <#if properties.stylesCommon?has_content>
        <#list properties.stylesCommon?split(' ') as style>
            <link href="${url.resourcesCommonPath}/${style}" rel="stylesheet" />
        </#list>
    </#if>
    <#if properties.styles?has_content>
        <#list properties.styles?split(' ') as style>
            <link href="${url.resourcesPath}/${style}" rel="stylesheet" />
        </#list>
    </#if>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
</head>

<body class="${properties.kcBodyClass!}">
    <div class="login-pf-page">
        <div id="kc-header" class="login-pf-page-header">
            <div id="kc-header-wrapper" class="${properties.kcHeaderWrapperClass!}">
                ${kcSanitize(msg("loginTitleHtml",(realm.displayNameHtml!'')))?no_esc}
            </div>
        </div>
        <div class="card-pf">
            <div id="kc-content">
                <div id="kc-content-wrapper">
                    <#nested "form">
                </div>
            </div>
        </div>
    </div>
</body>
</html>
</#macro>