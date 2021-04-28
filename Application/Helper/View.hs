module Application.Helper.View where

import IHP.ViewPrelude
import Generated.Types

-- Here you can add functions which are available in all your views

type family MessagingConfig a  where
  MessagingConfig User =  Include' ["messages", "installerId"] Negotiation -- Other applications might have different
  MessagingConfig Installer =  Include' ["messages", "userId"] Negotiation -- data that you want in the chat context
