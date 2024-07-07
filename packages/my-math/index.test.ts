import { test, expect } from "vitest"
import { pow } from ".";

test("pow", () => {
    const actual = pow(4)
    const expected = 16
    expect(actual).toStrictEqual(expected)
})
