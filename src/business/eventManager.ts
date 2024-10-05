import { IDocument } from "../../common/document.ts";
import { SELECTDOCUMENT_EVENT } from "../../common/event.ts";
import { IWorkspace } from "../../common/workspace.ts";
import { ServiceManager } from "./serviceManager.ts";

export class EventManager {
    private _service : ServiceManager;
    private _workspace ?: IWorkspace;
    private _setWorkspace ?: React.Dispatch<React.SetStateAction<IWorkspace>>;

    public constructor(service: ServiceManager) {
        this._service = service;
    }

    public updateState(workspace: IWorkspace, setWorkspace: React.Dispatch<React.SetStateAction<IWorkspace>>) {
        this._workspace = workspace;
        this._setWorkspace = setWorkspace;
    }

    public selectDocument(document: IDocument) {
        return new Promise<IDocument|null>((resolve) => {
            const workspace = this._workspace;
            const setWorkspace = this._setWorkspace;
            if (this._service && workspace && setWorkspace) {
                this._service.loadDocumentByPath(document.path).then((doc) =>{
                    setWorkspace({
                        ...workspace,
                        selectedDocument: doc,
                        documents: workspace.documents.map((d => {
                            if (document.path === doc.path) { return { ...d, content: doc.content }
                            } else { return d; }
                        }))
                    })
                    resolve(doc);
                }).catch(() => {
                    resolve(null);
                })
            } else {
                resolve(null);
            }
        });
    }

    public unSelectDocument() {
        const workspace = this._workspace;
        const setWorkspace = this._setWorkspace;
        if (workspace && setWorkspace) {
            setWorkspace({
                ...workspace,
                selectedDocument: undefined
            })
        }
    }

    public addFile(newFileName: string) {
        return new Promise<void>((resolve) => {
            const workspace = this._workspace;
            const setWorkspace = this._setWorkspace;
            if (this._service && workspace && setWorkspace) {
                this._service.addNewFile(newFileName).then((doc) => {
                    setWorkspace({
                        ...workspace,
                        selectedDocument: doc,
                        documents: [ ...workspace.documents, doc ]
                    })
                }).finally(() => {
                    resolve();
                })
            } else {
                resolve();
            }
        });
    }

    public updateFile(id: string, path: string, content: string) {
        return new Promise<void>((resolve) => {
            const workspace = this._workspace;
            const setWorkspace = this._setWorkspace;
            if (this._service && workspace && setWorkspace) {
                this._service.updateFileContent(id, path, content).then((doc) => {
                    setWorkspace({
                        ...workspace,
                        documents: workspace.documents.map((d => {
                            if (d.path === path) { return doc }
                            else { return d }
                        }))
                    })
                }).finally(() => {
                    resolve();
                })
            } else {
                resolve();
            }
        });
    }

    public deleteFile(path: string) {
        return new Promise<void>((resolve) => {
            const service = this._service;
            const workspace = this._workspace;
            const setWorkspace = this._setWorkspace;
            if (service && workspace && setWorkspace) {
                service.deleteFile(path).then(() => {
                    setWorkspace({
                        ...workspace,
                        documents: workspace.documents.filter(d => { return d.path !== path; })
                    })
                }).finally(() => {
                    resolve();
                })
            } else {
                resolve();
            }
        });
    }

    public renameFile(id: string, oldPath: string, newPath: string) {
        return new Promise<void>((resolve) => {
            const workspace = this._workspace;
            const setWorkspace = this._setWorkspace;
            if (this._service && workspace && setWorkspace) {
                this._service.renameFile(oldPath, newPath).then(() => {
                    setWorkspace({
                        ...workspace,
                        documents: workspace.documents.map(d => {
                            if (d.id === id) { return {
                                ...d,
                                path: newPath
                            } }
                            else { return d; }
                        })
                    })
                }).finally(() => {
                    resolve();
                })
            } else {
                resolve();
            }
        });
    }
}