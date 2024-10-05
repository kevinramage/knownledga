import { v4 } from "uuid";
import { IDocument } from "../../common/document.ts";
import { IWorkspace } from "../../common/workspace.ts";

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
            fetch(this._url + "/api/v1/document/read", {headers: headers, body: JSON.stringify(body), method: "POST"}).then((res) => {
                res.json().then((data) => {
                  resolve(data as IDocument);
                })
            });
        });
    }

    public addNewFile(path: string) {
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

    public updateFileContent(id: string, path: string, content: string) {
        return new Promise<IDocument>((resolve) => {
            const headers = { "Content-Type": "application/json" };
            const body = { "id": id, "path": path, "content": content }
            fetch(this._url + "/api/v1/document/", {headers: headers, body: JSON.stringify(body), method: "PUT"}).then((res) => {
                res.json().then((data) => {
                  resolve(data as IDocument);
                })
            });
        });
    }

    public deleteFile(path: string) {
        return new Promise<void>((resolve) => {
            const headers = { "Content-Type": "application/json" };
            const body = { "path": path }
            fetch(this._url + "/api/v1/document/", {headers: headers, body: JSON.stringify(body), method: "DELETE"}).then((res) => {
                res.json().then(() => {
                  resolve();
                })
            });
        });
    }

    public renameFile(oldPath: string, newPath: string) {
        return new Promise<void>((resolve) => {
            const headers = { "Content-Type": "application/json" };
            const body = { "oldPath": oldPath, "newPath": newPath }
            fetch(this._url + "/api/v1/document/rename", {headers: headers, body: JSON.stringify(body), method: "POST"}).then((res) => {
                res.json().then(() => {
                  resolve();
                })
            });
        });
    }
}