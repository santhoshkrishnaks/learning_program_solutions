import './App.css';
import { CalculateScore } from './Components/CalculateScore';

function App() {
  return (
    <div>
      <CalculateScore
        Name={"Santhosh Krishna"}
        School={"Jaycees Matric Higher Sec. School"}
        total={479}
        goal={5}
      />
    </div>
  );
}

export default App;
