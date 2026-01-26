<#ftl strip_whitespace=true>
<#import "template.ftl" as layout>
<@layout.registrationLayout displayInfo=false displayMessage=!messagesPerField.existsError('username','password'); section>
    <#if section = "header">
        Coral-io Login
    <#elseif section = "form">
        <div class="container">
            <!-- Sign In Form -->
            <div class="form-container sign-in-container">
                <form id="kc-form-login" action="${url.loginAction}" method="post">
                    <h1>Sign in</h1>

                    <div class="social-container">
                        <a href="#" class="social"><i class="fab fa-facebook-f"></i></a>
                        <a href="#" class="social"><i class="fab fa-google-plus-g"></i></a>
                        <a href="#" class="social"><i class="fab fa-linkedin-in"></i></a>
                    </div>

                    <span>or use your account</span>
<br>
                    <#if messagesPerField.existsError('username','password')>
                        <div class="alert alert-error">
                            ${kcSanitize(messagesPerField.getFirstError('username','password'))?no_esc}
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
                    
                    <#-- Lien vers la page de réinitialisation de mot de passe de Keycloak -->
                    <div class="forgot-password-link">
                        <a href="${url.loginResetCredentialsUrl}">Forgot your password?</a>
                    </div>
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
                if (forgotPasswordBtn) {
                    forgotPasswordBtn.addEventListener('click', function(e) {
                        // Si c'est un bouton dans l'overlay, on anime d'abord
                        if (e.target.classList.contains('ghost') && !container.classList.contains('right-panel-active')) {
                            e.preventDefault();
                            // Animation du slide
                            container.classList.add('right-panel-active');
                            // Après l'animation, suivre le lien
                            setTimeout(() => {
                                window.location.href = e.target.href;
                            }, 600);
                        }
                    });
                }
                
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