import { test, expect } from "vitest"
import { myPow } from "./math"

test("myPow", () => {
    const actual = myPow(3)
    const expected = 9
    expect(actual).toStrictEqual(expected)
})
