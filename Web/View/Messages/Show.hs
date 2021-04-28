module Web.View.Messages.Show where
import Web.View.Prelude

data ShowView = ShowView { message :: Message }

instance View ShowView where
    html ShowView { .. } = [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href={MessagesAction}>Messages</a></li>
                <li class="breadcrumb-item active">Show Message</li>
            </ol>
        </nav>
        <h1>Show Message</h1>
        <p>{message}</p>
    |]
