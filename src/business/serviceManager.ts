import { IDocument } from "../../common/document";
import { IWorkspace } from "../../common/workspace";

const DEFAULT_URL = "http://localhost:3000";

export class ServiceManager {
    private _url : string;

    public constructor() {
        this._url = DEFAULT_URL;
    }

    public loadWorkspaceByName(name: string) {
        return new Promise<IWorkspace>((resolve) => {
            fetch(this._url + "/api/v1/workspace/" + name).then((res) => {
                res.json().then((data) => {
                  resolve(data as IWorkspace);
                })
            });
        });
    }

    public loadDocumentByPath(path: string) {
        return new Promise<IDocument>((resolve) => {
            const headers = { "Content-Type": "application/json" };
            const body = { "path": path }
            fetch(this._url + "/api/v1/document/", {headers: headers, body: JSON.stringify(body), method: "POST"}).then((res) => {
                res.json().then((data) => {
                  resolve(data as IDocument);
                })
            });
        });
    }
}