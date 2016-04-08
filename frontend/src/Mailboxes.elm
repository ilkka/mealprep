module Mailboxes (..) where

import Actions exposing (..)


actionsMailbox : Signal.Mailbox Action
actionsMailbox =
  Signal.mailbox NoOp



-- We can use "Int" here to make this mailbox suitable for
-- asking confirmation for deleting anything with an int id


deleteConfirmationMailbox : Signal.Mailbox ( Int, String )
deleteConfirmationMailbox =
  Signal.mailbox ( 0, "" )
