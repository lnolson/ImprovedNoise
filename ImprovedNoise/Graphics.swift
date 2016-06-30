//
//  Graphics.swift
//  ImprovedNoise
//
//  Created by Loren Olson on 6/30/16.
//  To demo/test ImprovedNoise, use it to create a Brownian texture.

import Cocoa

class Graphics: NSView {
    
    var octaves = 5
    var gain = 0.75
    var lacunarity = 1.99
    var frequency = 0.025
    

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        if let context = NSGraphicsContext.current() {
            let cg = context.cgContext
            cg.setFillColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)
            cg.fill(CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
            
            let imageWidth = Int(self.frame.width)
            let imageHeight = Int(self.frame.height)
            let bitmap = NSBitmapImageRep(bitmapDataPlanes: nil, pixelsWide: imageWidth, pixelsHigh: imageHeight, bitsPerSample: 8, samplesPerPixel: 3, hasAlpha: false, isPlanar: false, colorSpaceName: NSCalibratedRGBColorSpace, bytesPerRow: 0, bitsPerPixel: 0)!
            
            var min = 100000.0
            var max = -100000.0
            for y in 0..<imageHeight {
                for x in 0..<imageWidth {
                    
                    let noise = brownian(x: Double(x), y: Double(y), z: 0.0, octaves: octaves, frequency: frequency, lacunarity: lacunarity, gain: gain) * 0.5 + 0.5
                    if noise < min {
                        min = noise
                    }
                    else if noise > max {
                        max = noise
                    }
                    
                    let clampedNoise = CGFloat( clamp(value: Double(noise), min: 0.0, max: 1.0))
                    let c = NSColor(calibratedRed: clampedNoise, green: clampedNoise, blue: clampedNoise, alpha: 1.0)
                    
                    bitmap.setColor(c, atX: x, y: y)
                }
            }
            
            Swift.print("(min,max) == \(min),\(max)")
            
            let rect = CGRect(x: 0.0, y: 0.0, width: self.frame.width, height: self.frame.height)
            cg.draw(in: rect, image: bitmap.cgImage!)
        }
    }
    
    // fractional brownian motion
    func brownian( x: Double, y: Double, z: Double, octaves: Int, frequency: Double, lacunarity: Double, gain: Double) -> Double {
        var sum = 0.0
        var lambda = frequency
        var amplitude = 1.0
        for _ in 0..<octaves {
            let u = x * lambda
            let v = y * lambda
            let w = z * lambda
            sum += amplitude * ImprovedNoise.noise(x: u, y: v, z: w)
            lambda *= lacunarity
            amplitude *= gain
        }
        
        return sum
    }
    
    func smoothStep( value: Double, min: Double, max: Double ) -> Double {
        let v = clamp(value: (value - min)/(max - min), min: 0.0, max: 1.0)
        return v * v * (-2.0 * v + 3.0)
    }
    
    func clamp( value: Double, min: Double, max: Double ) -> Double {
        return (value < min) ? (min) : (value > max) ? max : value
    }
    
}
