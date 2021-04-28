module Web.Types where

import IHP.Prelude
import IHP.ModelSupport
import Generated.Types

data WebApplication = WebApplication deriving (Eq, Show)


data StaticController = WelcomeAction deriving (Eq, Show, Data)

data UsersController
    = UsersAction
    | NewUserAction
    | ShowUserAction { userId :: !(Id User) }
    | CreateUserAction
    | EditUserAction { userId :: !(Id User) }
    | UpdateUserAction { userId :: !(Id User) }
    | DeleteUserAction { userId :: !(Id User) }
    deriving (Eq, Show, Data)

data InstallersController
    = InstallersAction
    | NewInstallerAction
    | ShowInstallerAction { installerId :: !(Id Installer) }
    | CreateInstallerAction
    | EditInstallerAction { installerId :: !(Id Installer) }
    | UpdateInstallerAction { installerId :: !(Id Installer) }
    | DeleteInstallerAction { installerId :: !(Id Installer) }
    deriving (Eq, Show, Data)

data MessagesController
    = MessagesAction
    | NewMessageAction
    | ShowMessageAction { messageId :: !(Id Message) }
    | CreateMessageAction
    | EditMessageAction { messageId :: !(Id Message) }
    | UpdateMessageAction { messageId :: !(Id Message) }
    | DeleteMessageAction { messageId :: !(Id Message) }
    deriving (Eq, Show, Data)
