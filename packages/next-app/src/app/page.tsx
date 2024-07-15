import styles from "./page.module.css";
import { myPow } from "./math";

export default function Home() {
  const num = 8
  const powResult = myPow(num)

  return (
    <main className={styles.main}>
      <p className={styles.example}>{`${num} * ${num} = ${powResult}`}</p>
    </main>
  );
}
