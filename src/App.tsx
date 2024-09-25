import { useEffect } from 'react'
import './App.css'
import { MarkdownRendererView } from './component/markdown/renderer'

function App() {

  useEffect(() => {
    fetch("http://localhost:3000/").then((res) => {
      res.text().then((content) => {
        console.info(content);
      })
    })
  }, [])

  return (
    <>
      <MarkdownRendererView />
    </>
  )
}

export default App
