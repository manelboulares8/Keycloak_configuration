<#ftl strip_whitespace=true>
<#import "template.ftl" as layout>
<@layout.registrationLayout displayInfo=false displayMessage=!messagesPerField.existsError('username','password'); section>
    <#if section = "header">
        Coral-io Login
    <#elseif section = "form">
        <div class="container">
      
      
       <#-- Affichage des messages de reset password -->
<#if message??>
    <#if message.type == 'success'>
        <div class="alert alert-success">
            ${message.summary?if_exists}  <#-- message de type succès, ex: email envoyé -->
        </div>
    <#elseif message.type == 'error'>
        <div class="alert alert-error">
            <#-- Cas spécifique pour utilisateur non trouvé -->
            <#if message.summary?contains('USER_NOT_FOUND')>
                L'utilisateur ou l'email n'existe pas.
            <#else>
                ${message.summary?if_exists}  <#-- autre erreur -->
            </#if>
        </div>
    </#if>
</#if>


            <!-- Sign In Form -->
            <div class="form-container sign-in-container">
            
                <form id="kc-form-login" action="${url.loginAction}" method="post">
                    <h1>Sign in</h1>
                        <br><br>
                    

                    <span>Veuillez saisir vos coordonnées</span>
<br><br>
                  <#if message?? && message.type == 'error'>
    <div class="login-error">
        Email ou mot de passe incorrect. Veuillez réessayer.
    </div>
</#if>



                    <input type="text" 
                           name="username" 
                           placeholder="Email or Username" 
                           value="${(login.username!'')}" 
                           autofocus
                           aria-invalid="<#if messagesPerField.existsError('username','password')>true</#if>"/>

                    <input type="password" 
                           name="password" 
                           placeholder="Password"
                           aria-invalid="<#if messagesPerField.existsError('username','password')>true</#if>"/>

                    <#if realm.rememberMe>
                        <div class="checkbox">
                            <label>
                                <input type="checkbox" 
                                       id="rememberMe" 
                                       name="rememberMe" 
                                       <#if login.rememberMe??>checked</#if>/>
                                Remember me
                            </label>
                        </div>
                    </#if>
                    <br>
                    <button type="submit">Sign In</button>
                    <br><br>
                    <#-- Lien vers la page de réinitialisation de mot de passe de Keycloak -->
                  
                </form>
            </div>

            <!-- Overlay avec animation seulement (pas de formulaire de reset ici) -->
            <div class="overlay-container">
                <div class="overlay">
                    <div class="overlay-panel overlay-left">
                        <h1>Welcome Back!</h1>
                        <p>To keep connected with us please login with your personal info</p>
                        <button class="ghost" id="signIn">Sign In</button>
                    </div>

                    <div class="overlay-panel overlay-right">
                        <h1>Forgot Password?</h1>
                        <p>Click the link below to reset your password</p>
                        <a href="${url.loginResetCredentialsUrl}" class="ghost" id="forgotPasswordBtn">Reset Password</a>
                    </div>
                </div>
            </div>
        </div>

        <script>
            document.addEventListener('DOMContentLoaded', function() {
                const forgotPasswordBtn = document.getElementById('forgotPasswordBtn');
                const signInButton = document.getElementById('signIn');
                const container = document.querySelector('.container');
                
                // Animation seulement pour le bouton "Forgot Password" dans l'overlay
                
                
                // Bouton "Sign In" dans l'overlay - animation seulement
                if (signInButton) {
                    signInButton.addEventListener('click', function(e) {
                        e.preventDefault();
                        container.classList.remove('right-panel-active');
                    });
                }
                
                // Vérifier si on doit montrer l'animation au chargement
                <#if message?? && message.type == 'error' && message.summary??>
                    <#if message.summary?contains('password') || message.summary?contains('credentials')>
                        container.classList.add('right-panel-active');
                    </#if>
                </#if>
            });
        </script>
    <#elseif section = "info">
        <#if realm.password && realm.resetPasswordAllowed>
            <div id="kc-password-reset">
                <span>Forgot your password? <a href="${url.loginResetCredentialsUrl}">Reset it here</a></span>
            </div>
        </#if>
    </#if>
</@layout.registrationLayout>