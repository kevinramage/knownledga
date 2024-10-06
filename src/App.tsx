import { useEffect, useState } from 'react'
import './App.css'
import { Panel, PanelGroup, PanelResizeHandle } from 'react-resizable-panels'
import { DEFAULT_OPTIONS } from '../common/options.ts'
import { FileExporerView } from './component/fileExplorer/view.tsx'
import { DEFAULT_WORKSPACE, IWorkspace } from '../common/workspace.ts'
import { MarkdownView } from './component/markdown/view.tsx'
import { ServiceManager } from './business/serviceManager.ts'
import { EventManager } from './business/eventManager.ts'

const serviceManager = new ServiceManager();
const eventManager = new EventManager(serviceManager);

function App() {
  
  const [ options, setOptions ] = useState(DEFAULT_OPTIONS);
  const [ workspace, setWorkspace ] = useState(DEFAULT_WORKSPACE);
  eventManager.updateState(workspace, setWorkspace);
  

  useEffect(() => {

    // Load default workspace
    serviceManager.loadWorkspaceByName("default").then((workspace) => { setWorkspace(workspace); });
  }, [])

  return (
    <PanelGroup className='mainPanel' direction='vertical' onLayout={(layouts) => {}}>
      { !options.panels.top.disable && (
        <>
        <Panel className='panel' minSize={10} defaultSize={options.panels.top.size} maxSize={30}>Top</Panel>
        <PanelResizeHandle className='panelResize' />
        </>
      )}
      <Panel className='panel' defaultSize={100}>
        <PanelGroup direction='horizontal'>
          <Panel className='panel' defaultSize={options.panels.left.size} minSize={10} maxSize={20}>
            <FileExporerView workspace={workspace} eventManager={eventManager} />
          </Panel>
          <PanelResizeHandle className='panelResize' />
          <Panel className='panel panelWithoutFlex'>
            { workspace.selectedDocument && (
                <MarkdownView document={workspace.selectedDocument} eventManager={eventManager} />
            )}
          </Panel>
          { !options.panels.right.disable && (
          <>
          <PanelResizeHandle className='panelResize' />
          <Panel className='panel' defaultSize={options.panels.right.size} maxSize={5}>Right</Panel>
          </>
          )}
        </PanelGroup>
      </Panel>
      { !options.panels.bottom.disable && (
      <>
      <PanelResizeHandle className='panelResize' />
      <Panel className='panel' minSize={10} defaultSize={options.panels.bottom.size} maxSize={30}>Bottom</Panel>
      </>
      )}
    </PanelGroup>
  )
}

export default App
