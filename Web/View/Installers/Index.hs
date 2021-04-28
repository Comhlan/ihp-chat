module Web.View.Installers.Index where
import Web.View.Prelude

data IndexView = IndexView { installers :: [Installer] }

instance View IndexView where
    html IndexView { .. } = [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item active"><a href={InstallersAction}>Installers</a></li>
            </ol>
        </nav>
        <h1>Index <a href={pathTo NewInstallerAction} class="btn btn-primary ml-4">+ New</a></h1>
        <div class="table-responsive">
            <table class="table">
                <thead>
                    <tr>
                        <th>Installer</th>
                        <th></th>
                        <th></th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>{forEach installers renderInstaller}</tbody>
            </table>
        </div>
    |]


renderInstaller installer = [hsx|
    <tr>
        <td>{installer}</td>
        <td><a href={ShowInstallerAction (get #id installer)}>Show</a></td>
        <td><a href={EditInstallerAction (get #id installer)} class="text-muted">Edit</a></td>
        <td><a href={DeleteInstallerAction (get #id installer)} class="js-delete text-muted">Delete</a></td>
    </tr>
|]
