module Web.View.Messages.Index where
import Web.View.Prelude

data IndexView = IndexView { messages :: [Message] }

instance View IndexView where
    html IndexView { .. } = [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item active"><a href={MessagesAction}>Messages</a></li>
            </ol>
        </nav>
        <h1>Index <a href={pathTo NewMessageAction} class="btn btn-primary ml-4">+ New</a></h1>
        <div class="table-responsive">
            <table class="table">
                <thead>
                    <tr>
                        <th>Message</th>
                        <th></th>
                        <th></th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>{forEach messages renderMessage}</tbody>
            </table>
        </div>
    |]


renderMessage message = [hsx|
    <tr>
        <td>{message}</td>
        <td><a href={ShowMessageAction (get #id message)}>Show</a></td>
        <td><a href={EditMessageAction (get #id message)} class="text-muted">Edit</a></td>
        <td><a href={DeleteMessageAction (get #id message)} class="js-delete text-muted">Delete</a></td>
    </tr>
|]
