export interface IDocument {
    id: string;
    name: string;
    path: string;
    relativePath: string;
    content: string;
    type: DOCUMENT_TYPE;
    subDocuments: IDocument[];
}

export type DOCUMENT_TYPE = "FOLDER" | "MARKDOWN" | "UNKNOWN";