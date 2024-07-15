import Image from "next/image";
import styles from "./header.module.css";

export default function Header() {
    return (
        <div className={styles.container}>
            <Image
                src="/next.svg"
                alt="Next.js Logo"
                width={100}
                height={50}
                priority
            />
            <span>Example</span>
        </div>
    )
}