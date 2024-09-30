import { AppBar, Box, IconButton, Toolbar, Typography } from "@mui/material";
import { SimpleTreeView } from '@mui/x-tree-view/SimpleTreeView';
import { TreeItem } from "@mui/x-tree-view";
import { IWorkspace } from "../../../common/workspace.ts";
import { IDocument } from "../../../common/document.ts";
import { SELECTDOCUMENT_EVENT } from "../../../common/event.ts";

export interface IFileExplorerViewProps {
    workspace: IWorkspace
}

export function FileExporerView(props: IFileExplorerViewProps) {
    const { workspace } = props;
    return (
        <Box className="fileExplorerView">
            <AppBar position="relative">
                <Toolbar>
                    <IconButton>
                        {/*<FolderOpenIcon fill="#F8D775" htmlColor="#F8D775" />*/}
                    </IconButton>
                    <Typography>File explorer</Typography>
                </Toolbar>
                <SimpleTreeView>
                    { workspace && workspace.documents.map(d => {
                        return (
                            <TreeItem key={d.id} itemId={d.id} label={d.name} onClick={(e) => { e.stopPropagation(); selectDocument(d); } } />
                        )
                    })}
                </SimpleTreeView>
            </AppBar>
        </Box>
    )
}

function selectDocument(doc: IDocument) {
    const event = new CustomEvent(SELECTDOCUMENT_EVENT, { detail: { document: doc } });
    document.dispatchEvent(event);
}