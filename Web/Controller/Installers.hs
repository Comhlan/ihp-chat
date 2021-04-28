module Web.Controller.Installers where

import Web.Controller.Prelude
import Web.View.Installers.Index
import Web.View.Installers.New
import Web.View.Installers.Edit
import Web.View.Installers.Show

instance Controller InstallersController where
    action ShowInstallerAction { installerId } = autoRefresh do
        installer <- fetch installerId
        negotiation <- query @Negotiation
                        |> fetchOne
                        >>= fetchRelated #messages
                        >>= fetchRelated #userId
        render ShowView { .. }

    action InstallersAction = do
        installers <- query @Installer |> fetch
        render IndexView { .. }

    action NewInstallerAction = do
        let installer = newRecord
        render NewView { .. }

    action EditInstallerAction { installerId } = do
        installer <- fetch installerId
        render EditView { .. }

    action UpdateInstallerAction { installerId } = do
        installer <- fetch installerId
        installer
            |> buildInstaller
            |> ifValid \case
                Left installer -> render EditView { .. }
                Right installer -> do
                    installer <- installer |> updateRecord
                    setSuccessMessage "Installer updated"
                    redirectTo EditInstallerAction { .. }

    action CreateInstallerAction = do
        let installer = newRecord @Installer
        installer
            |> buildInstaller
            |> ifValid \case
                Left installer -> render NewView { .. }
                Right installer -> do
                    installer <- installer |> createRecord
                    setSuccessMessage "Installer created"
                    redirectTo InstallersAction

    action DeleteInstallerAction { installerId } = do
        installer <- fetch installerId
        deleteRecord installer
        setSuccessMessage "Installer deleted"
        redirectTo InstallersAction

buildInstaller installer = installer
    |> fill @["name","email","passwordHash","failedLoginAttempts"]
