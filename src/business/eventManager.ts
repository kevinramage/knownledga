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
    
    public listen() {
        document.addEventListener
        document.addEventListener(SELECTDOCUMENT_EVENT, (e) => { 
            const customEvent = e as CustomEvent;
            this.selectDocumentEvent(customEvent); 
            customEvent.stopImmediatePropagation() 
        }, true );
    }

    private selectDocumentEvent(e: CustomEvent) {
        const document = e.detail.document as IDocument;
        if (this._service) {
            this._service.loadDocumentByPath(document.path).then((doc) => {
                if (this._workspace && this._setWorkspace) {
                    this._setWorkspace({
                        ...this._workspace,
                        selectedDocument: doc,
                        documents: this._workspace.documents.map((d => {
                            if (d.path === doc.path) { return { ...d, content: doc.content }
                            } else { return d; }
                        }))
                    })
                }
            });
        }
    }
}