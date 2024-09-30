import { IDocument } from "../../common/document";
import { SELECTDOCUMENT_EVENT } from "../../common/event";
import { IWorkspace } from "../../common/workspace";
import { ServiceManager } from "./serviceManager";

export class EventManager {
    private _service : ServiceManager;
    private _workspace : IWorkspace;
    private _setWorkspace : React.Dispatch<React.SetStateAction<IWorkspace>>;

    public constructor(service: ServiceManager) {
        this._service = service;
    }

    public updateState(workspace: IWorkspace, setWorkspace: React.Dispatch<React.SetStateAction<IWorkspace>>) {
        this._workspace = workspace;
        this._setWorkspace = setWorkspace;
    }
    
    public listen() {
        document.addEventListener(SELECTDOCUMENT_EVENT, (e : CustomEvent) => { this.selectDocumentEvent(e); e.stopPropagation(); e.stopImmediatePropagation() }, true );
    }

    private selectDocumentEvent(e: CustomEvent) {
        const document = e.detail.document as IDocument;
        this._service.loadDocumentByPath(document.path).then((doc) => {
            this._setWorkspace({
                ...this._workspace,
                selectedDocument: doc,
                documents: this._workspace.documents.map((d => {
                    if (d.path === doc.path) { return { ...d, content: doc.content }
                    } else { return d; }
                }))
            })
        });
    }
}