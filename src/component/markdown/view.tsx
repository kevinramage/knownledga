import { Panel, PanelGroup, PanelResizeHandle } from "react-resizable-panels";
import { MarkdownRendererView } from "./renderer";
import { IDocument } from "../../../common/document";
import { MarkdownEditor } from "./editor";

export interface IMarkdownViewProps {
    document: IDocument
}

export function MarkdownView(props: IMarkdownViewProps) {
    const { document } = props;
    return (
        <PanelGroup direction="horizontal">
            <Panel className="panel">
                <MarkdownEditor document={document} />
            </Panel>
            <PanelResizeHandle className='panelResize' />
            <Panel className="panel">
                <MarkdownRendererView document={document} />
            </Panel>
        </PanelGroup>
    )
}