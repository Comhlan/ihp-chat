module Web.View.Installers.Edit where
import Web.View.Prelude

data EditView = EditView { installer :: Installer }

instance View EditView where
    html EditView { .. } = [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href={InstallersAction}>Installers</a></li>
                <li class="breadcrumb-item active">Edit Installer</li>
            </ol>
        </nav>
        <h1>Edit Installer</h1>
        {renderForm installer}
    |]

renderForm :: Installer -> Html
renderForm installer = formFor installer [hsx|
    {(textField #name)}
    {(textField #email)}
    {(textField #passwordHash)}
    {(textField #failedLoginAttempts)}
    {submitButton}
|]
