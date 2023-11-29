import React, { useState } from 'react';
import api from './api';

function App() {
  const [createInput, setCreateInput] = useState('');
  const [deleteInput, setDeleteInput] = useState('');
  const [createDeleteInput, setCreateDeleteInput] = useState('');
  const [result, setResult] = useState('');

  const handleCreate = async () => {
    setResult(await api.createDatum(createInput));
  };

  const handleDelete = async () => {
    setResult(await api.deleteDatum(deleteInput));
  };

  const handleCreateAndDelete = async () => {
    setResult(await api.createAndDelete(createDeleteInput));
  };

  return (
    <div>
      <div>
        <input
          type="text"
          value={createInput}
          onChange={(e) => setCreateInput(e.target.value)}
          placeholder="Enter some text"
        />
        <button onClick={handleCreate}>Create</button>
      </div>
      <div>
        <input
          type="text"
          value={deleteInput}
          onChange={(e) => setDeleteInput(e.target.value)}
          placeholder="Enter a datum ID"
        />
        <button onClick={handleDelete}>Delete</button>
      </div>
      <div>
        <input
          type="text"
          value={createDeleteInput}
          onChange={(e) => setCreateDeleteInput(e.target.value)}
          placeholder="Enter some text"
        />
        <button onClick={handleCreateAndDelete}>Create and Delete</button>
      </div>
      <div>
        <p>API Result:</p>
        <pre style={{ fontFamily: 'sans-serif', whiteSpace: 'pre-wrap' }}>{result}</pre>
      </div>
    </div>
  );
}

export default App;