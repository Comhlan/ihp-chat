module Web.View.Static.Welcome where
import Web.View.Prelude
import Web.Controller.Prelude

data WelcomeView = WelcomeView {
                                 user :: User
                               , installer :: Installer
                               }

instance View WelcomeView where
    html WelcomeView { .. }= [hsx|
    <div>
    <a href = {ShowUserAction (get #id user)}> User Landing Page. </a>
    </div>
    <div>
    <a href = {ShowInstallerAction (get #id installer)}> Installer Landing Page.</a>
    </div>
|]
