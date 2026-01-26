<#ftl strip_whitespace=true>
<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('username'); section>
    <#if section = "header">
        Reset Password
    <#elseif section = "form">
        <div class="reset-password-container">
            <h1>Reset Your Password</h1>
            <p>Enter your username or email to receive reset instructions.</p>
            
            <form id="kc-reset-password-form" action="${url.loginAction}" method="post">
                <#if messagesPerField.existsError('username')>
                    <div class="alert alert-error">
                        ${kcSanitize(messagesPerField.getFirstError('username'))?no_esc}
                    </div>
                </#if>

                <input type="text" 
                       id="username" 
                       name="username" 
                       value="${(auth.attemptedUsername!'')}" 
                       placeholder="Username or Email" 
                       autofocus
                       aria-invalid="<#if messagesPerField.existsError('username')>true</#if>"/>

                <button type="submit">Submit</button>
                
                <div class="back-to-login">
                    <a href="${url.loginUrl}">Back to Login</a>
                </div>
            </form>
        </div>
        
        <style>
            .reset-password-container {
                background: white;
                padding: 40px;
                border-radius: 10px;
                box-shadow: 0 14px 28px rgba(0,0,0,0.25);
                width: 400px;
                max-width: 90%;
                text-align: center;
                margin: 0 auto;
            }
            
            .reset-password-container h1 {
                color: #333;
                margin-bottom: 10px;
            }
            
            .reset-password-container p {
                color: #666;
                margin-bottom: 30px;
                font-size: 14px;
            }
            
            .back-to-login {
                margin-top: 20px;
                font-size: 14px;
            }
            
            .back-to-login a {
                color: #FF4B2B;
                text-decoration: none;
            }
            
            .back-to-login a:hover {
                text-decoration: underline;
            }
        </style>
    </#if>
</@layout.registrationLayout>