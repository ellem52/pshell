#!/usr/bin/env swift
// Danny's rewrite of phonetic.pl 03162022 — Swift port of phonetic.ps1

import Foundation

func phonetic(for char: Character) -> String {
    // PowerShell's switch is case-insensitive by default
    switch char.lowercased() {
    case "a": return "alpha"
    case "b": return "bravo"
    case "c": return "charlie"
    case "d": return "delta"
    case "e": return "echo"
    case "f": return "foxtrot"
    case "g": return "golf"
    case "h": return "hotel"
    case "i": return "india"
    case "j": return "juliet"
    case "k": return "kilo"
    case "l": return "lima"
    case "m": return "mike"
    case "n": return "november"
    case "o": return "oscar"
    case "p": return "papa"
    case "q": return "quebec"
    case "r": return "romeo"
    case "s": return "sierra"
    case "t": return "tango"
    case "u": return "uniform"
    case "v": return "victor"
    case "w": return "whiskey"
    case "x": return "xray"
    case "y": return "yankee"
    case "z": return "zulu"
    case "1": return "one"
    case "2": return "two"
    case "3": return "tree"
    case "4": return "four"
    case "5": return "fife"
    case "6": return "six"
    case "7": return "seven"
    case "8": return "eight"
    case "9": return "niner"
    case "0": return "zero"
    case " ": return ""
    default: return String(char)
    }
}

func readLinePrompt(_ prompt: String) -> String {
    print(prompt, terminator: "")
    fflush(stdout)
    return readLine() ?? ""
}

repeat {
    let str = readLinePrompt("Enter letters & numbers: ")
    print("\nPhonetically: \n")

    for char in str {
        print(phonetic(for: char))
    }

    let continueAnswer = readLinePrompt("\nWould you like to enter more Letters & Numbers: Y or N: ")
        .trimmingCharacters(in: .whitespacesAndNewlines)
        .lowercased()

    if continueAnswer != "y" && continueAnswer != "yes" {
        break
    }
} while true
