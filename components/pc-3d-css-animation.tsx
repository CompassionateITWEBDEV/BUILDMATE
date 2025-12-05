"use client"

import { useState, useEffect } from "react"
import { RotateCcw, ZoomIn, ZoomOut, Move } from "lucide-react"
import { Button } from "@/components/ui/button"

interface PC3DCSSAnimationProps {
  currentStep: number
  className?: string
}

export function PC3DCSSAnimation({ currentStep = 1, className = "" }: PC3DCSSAnimationProps) {
  const [rotation, setRotation] = useState({ x: 15, y: 45 })
  const [zoom, setZoom] = useState(1)
  const [isDragging, setIsDragging] = useState(false)
  const [dragStart, setDragStart] = useState({ x: 0, y: 0 })

  // Step-based component visibility based on actual build process
  const stepComponents: Record<number, string[]> = {
    // Step 1: Prepare workspace - show all components laid out (not assembled)
    1: ['motherboard', 'cpu', 'cpuCooler', 'ram1', 'ram2', 'ssd', 'gpu', 'psu', 'caseFans'],
    // Step 2: Install CPU on motherboard - motherboard with CPU
    2: ['motherboard', 'cpu'],
    // Step 3: Install CPU Cooler - motherboard with CPU and cooler
    3: ['motherboard', 'cpu', 'cpuCooler'],
    // Step 4: Install RAM and SSD - motherboard with CPU, cooler, RAM, and SSD
    4: ['motherboard', 'cpu', 'cpuCooler', 'ram1', 'ram2', 'ssd'],
    // Step 5: Mount motherboard in case - case with motherboard inside
    5: ['case', 'motherboard', 'cpu', 'cpuCooler', 'ram1', 'ram2', 'ssd'],
    // Step 6: Install case fans - case with motherboard and fans
    6: ['case', 'motherboard', 'cpu', 'cpuCooler', 'ram1', 'ram2', 'ssd', 'caseFans'],
    // Step 7: Install PSU - case with motherboard, fans, and PSU
    7: ['case', 'motherboard', 'cpu', 'cpuCooler', 'ram1', 'ram2', 'ssd', 'caseFans', 'psu'],
    // Step 8: Install GPU - case with motherboard, fans, PSU, and GPU
    8: ['case', 'motherboard', 'cpu', 'cpuCooler', 'ram1', 'ram2', 'ssd', 'caseFans', 'psu', 'gpu'],
    // Step 9: Connect all cables - everything connected
    9: ['case', 'motherboard', 'cpu', 'cpuCooler', 'ram1', 'ram2', 'ssd', 'caseFans', 'psu', 'gpu', 'cables'],
    // Step 10: Close case - complete build
    10: ['case', 'motherboard', 'cpu', 'cpuCooler', 'ram1', 'ram2', 'ssd', 'caseFans', 'psu', 'gpu', 'cables'],
  }

  const visibleComponents = stepComponents[currentStep] || stepComponents[1]

  const handleMouseDown = (e: React.MouseEvent) => {
    setIsDragging(true)
    setDragStart({ x: e.clientX, y: e.clientY })
  }

  const handleMouseMove = (e: React.MouseEvent) => {
    if (!isDragging) return
    const deltaX = e.clientX - dragStart.x
    const deltaY = e.clientY - dragStart.y
    setRotation(prev => ({
      x: Math.max(-90, Math.min(90, prev.x - deltaY * 0.5)),
      y: prev.y + deltaX * 0.5
    }))
    setDragStart({ x: e.clientX, y: e.clientY })
  }

  const handleMouseUp = () => {
    setIsDragging(false)
  }

  const handleWheel = (e: React.WheelEvent) => {
    e.preventDefault()
    const delta = e.deltaY > 0 ? -0.1 : 0.1
    setZoom(prev => Math.max(0.5, Math.min(2, prev + delta)))
  }

  const resetView = () => {
    setRotation({ x: 15, y: 45 })
    setZoom(1)
  }

  return (
    <div className={`w-full aspect-video rounded-lg overflow-hidden border border-slate-200 dark:border-slate-700 bg-gradient-to-br from-slate-900 via-slate-800 to-slate-900 relative ${className}`}>
      {/* Controls */}
      <div className="absolute top-2 right-2 z-10 flex gap-2">
        <Button
          variant="secondary"
          size="sm"
          onClick={resetView}
          className="h-8 w-8 p-0"
          title="Reset view"
        >
          <RotateCcw className="h-4 w-4" />
        </Button>
        <Button
          variant="secondary"
          size="sm"
          onClick={() => setZoom(prev => Math.min(2, prev + 0.1))}
          className="h-8 w-8 p-0"
          title="Zoom in"
        >
          <ZoomIn className="h-4 w-4" />
        </Button>
        <Button
          variant="secondary"
          size="sm"
          onClick={() => setZoom(prev => Math.max(0.5, prev - 0.1))}
          className="h-8 w-8 p-0"
          title="Zoom out"
        >
          <ZoomOut className="h-4 w-4" />
        </Button>
      </div>

      {/* 3D Scene Container */}
      <div
        className="w-full h-full relative cursor-grab active:cursor-grabbing"
        onMouseDown={handleMouseDown}
        onMouseMove={handleMouseMove}
        onMouseUp={handleMouseUp}
        onMouseLeave={handleMouseUp}
        onWheel={handleWheel}
        style={{
          perspective: '1000px',
          perspectiveOrigin: '50% 50%',
        }}
      >
        <div
          className="absolute inset-0 flex items-center justify-center"
          style={{
            transform: `rotateX(${rotation.x}deg) rotateY(${rotation.y}deg) scale(${zoom})`,
            transformStyle: 'preserve-3d',
            transition: isDragging ? 'none' : 'transform 0.1s ease-out',
          }}
        >
          {/* PC Case - Realistic Style from Video */}
          {visibleComponents.includes('case') && (
            <div
              className="absolute"
              style={{
                width: '200px',
                height: '250px',
                transform: 'translateZ(0px)',
              }}
            >
              <div
                className="w-full h-full border-2 border-zinc-700 bg-zinc-900/30 backdrop-blur-sm rounded"
                style={{
                  boxShadow: '0 0 20px rgba(0, 0, 0, 0.5)',
                }}
              >
                {/* Case frame */}
                <div className="absolute inset-2 border border-zinc-600/50 rounded" />
                
                {/* Front panel */}
                <div className="absolute top-4 left-1/2 -translate-x-1/2 w-16 h-4 bg-zinc-800 border border-zinc-700 rounded flex items-center justify-center">
                  <div className="w-2 h-2 bg-blue-500 rounded-full" />
                </div>
                
                {/* Mesh ventilation */}
                <div className="absolute top-12 left-4 right-4">
                  {Array.from({ length: 12 }).map((_, i) => (
                    <div key={i} className="w-full h-0.5 bg-zinc-700/50 mb-1" />
                  ))}
                </div>
              </div>
            </div>
          )}

          {/* Motherboard - Realistic Style from Video */}
          {visibleComponents.includes('motherboard') && (
            <div
              className="absolute"
              style={{
                width: '180px',
                height: '200px',
                transform: visibleComponents.includes('case')
                  ? 'translateZ(10px) translateY(-60px)'
                  : 'translateZ(0px) translateX(0px) translateY(0px)',
              }}
            >
              <div
                className="w-full h-full bg-zinc-800 rounded border border-zinc-700"
                style={{
                  boxShadow: '0 4px 15px rgba(0, 0, 0, 0.5)',
                }}
              >
                {/* CPU Socket */}
                <div className="absolute top-10 left-1/2 -translate-x-1/2 w-12 h-12 border-2 border-zinc-600 bg-zinc-900" />
                
                {/* RAM Slots */}
                <div className="absolute top-10 right-4 space-y-1">
                  <div className="w-3 h-10 border border-zinc-600 bg-zinc-700/50" />
                  <div className="w-3 h-10 border border-zinc-600 bg-zinc-700/50" />
                </div>
                
                {/* PCIe Slots */}
                <div className="absolute bottom-16 left-4 right-4 space-y-1">
                  <div className="w-full h-2 border border-zinc-600 bg-zinc-700/50" />
                  <div className="w-3/4 h-2 border border-zinc-600 bg-zinc-700/30" />
                </div>
                
                {/* Chipset heatsink */}
                <div className="absolute bottom-8 left-1/2 -translate-x-1/2 w-12 h-8 bg-zinc-600 border border-zinc-500" />
              </div>
            </div>
          )}

          {/* CPU - Realistic Style from Video */}
          {visibleComponents.includes('cpu') && (
            <div
              className="absolute"
              style={{
                width: '35px',
                height: '35px',
                transform: visibleComponents.includes('motherboard') && !visibleComponents.includes('case')
                  ? 'translateZ(15px) translateY(-20px) translateX(0px)'
                  : visibleComponents.includes('case')
                  ? 'translateZ(15px) translateY(-60px)'
                  : 'translateZ(0px) translateX(-180px) translateY(-80px)',
              }}
            >
              <div
                className="w-full h-full bg-gradient-to-br from-slate-700 to-slate-800 rounded border border-slate-600"
                style={{
                  boxShadow: '0 0 10px rgba(59, 130, 246, 0.3)',
                }}
              >
                {/* CPU IHS (heat spreader) */}
                <div className="absolute inset-1 bg-slate-600 border border-slate-500" />
                {/* CPU label */}
                <div className="absolute inset-0 flex items-center justify-center text-[6px] text-slate-300 font-bold">
                  CPU
                </div>
              </div>
            </div>
          )}

          {/* CPU Cooler - Realistic Style from Video */}
          {visibleComponents.includes('cpuCooler') && (
            <div
              className="absolute"
              style={{
                width: '55px',
                height: '55px',
                transform: visibleComponents.includes('motherboard') && !visibleComponents.includes('case')
                  ? 'translateZ(20px) translateY(-20px) translateX(0px)'
                  : visibleComponents.includes('case')
                  ? 'translateZ(20px) translateY(-60px)'
                  : 'translateZ(0px) translateX(-100px) translateY(-80px)',
              }}
            >
              <div
                className="w-full h-full bg-gradient-to-br from-zinc-600 to-zinc-700 rounded-lg"
                style={{
                  boxShadow: '0 4px 15px rgba(0, 0, 0, 0.4)',
                }}
              >
                {/* Cooler fan */}
                <div className="absolute inset-0 flex items-center justify-center">
                  <div className="w-12 h-12 border-2 border-zinc-500 rounded-full bg-zinc-700/50">
                    {/* Fan hub */}
                    <div className="absolute inset-0 flex items-center justify-center">
                      <div className="w-4 h-4 bg-zinc-600 rounded-full" />
                    </div>
                    {/* Fan blades */}
                    <div className="absolute inset-0">
                      <div className="absolute top-1/2 left-1/2 w-1 h-10 bg-zinc-500 -translate-x-1/2 -translate-y-1/2" />
                      <div className="absolute top-1/2 left-1/2 w-10 h-1 bg-zinc-500 -translate-x-1/2 -translate-y-1/2" />
                    </div>
                  </div>
                </div>
              </div>
            </div>
          )}

          {/* RAM Modules - Realistic Style from Video */}
          {visibleComponents.includes('ram1') && (
            <div
              className="absolute"
              style={{
                width: '10px',
                height: '45px',
                transform: visibleComponents.includes('motherboard') && !visibleComponents.includes('case')
                  ? 'translateZ(15px) translateY(20px) translateX(70px)'
                  : visibleComponents.includes('case')
                  ? 'translateZ(15px) translateY(-40px) translateX(60px)'
                  : 'translateZ(0px) translateX(-200px) translateY(50px)',
              }}
            >
              <div
                className="w-full h-full bg-gradient-to-t from-green-800 to-green-700 rounded-sm border border-green-600"
                style={{
                  boxShadow: '0 2px 8px rgba(34, 197, 94, 0.3)',
                }}
              >
                {/* RAM heat spreader */}
                <div className="absolute inset-x-0.5 top-1 bottom-1 bg-green-700 border-l border-r border-green-600" />
              </div>
            </div>
          )}

          {visibleComponents.includes('ram2') && (
            <div
              className="absolute"
              style={{
                width: '10px',
                height: '45px',
                transform: visibleComponents.includes('motherboard') && !visibleComponents.includes('case')
                  ? 'translateZ(15px) translateY(20px) translateX(83px)'
                  : visibleComponents.includes('case')
                  ? 'translateZ(15px) translateY(-40px) translateX(-60px)'
                  : 'translateZ(0px) translateX(-160px) translateY(50px)',
              }}
            >
              <div
                className="w-full h-full bg-gradient-to-t from-green-800 to-green-700 rounded-sm border border-green-600"
                style={{
                  boxShadow: '0 2px 8px rgba(34, 197, 94, 0.3)',
                }}
              >
                {/* RAM heat spreader */}
                <div className="absolute inset-x-0.5 top-1 bottom-1 bg-green-700 border-l border-r border-green-600" />
              </div>
            </div>
          )}

          {/* SSD - Realistic Style from Video */}
          {visibleComponents.includes('ssd') && (
            <div
              className="absolute"
              style={{
                width: '70px',
                height: '20px',
                transform: visibleComponents.includes('motherboard') && !visibleComponents.includes('case')
                  ? 'translateZ(12px) translateY(-60px) translateX(0px)'
                  : visibleComponents.includes('case')
                  ? 'translateZ(12px) translateY(-30px) translateX(50px)'
                  : 'translateZ(0px) translateX(-70px) translateY(110px)',
              }}
            >
              <div
                className="w-full h-full bg-gradient-to-r from-zinc-700 to-zinc-800 rounded border border-zinc-600"
                style={{
                  boxShadow: '0 2px 8px rgba(0, 0, 0, 0.3)',
                }}
              >
                {/* SSD label */}
                <div className="absolute inset-0 flex items-center justify-center text-[8px] text-zinc-300 font-bold">
                  SSD
                </div>
              </div>
            </div>
          )}

          {/* GPU - Realistic Style from Video */}
          {visibleComponents.includes('gpu') && (
            <div
              className="absolute"
              style={{
                width: '120px',
                height: '60px',
                transform: visibleComponents.includes('case')
                  ? 'translateZ(20px) translateY(-20px)'
                  : 'translateZ(0px) translateX(80px) translateY(80px)',
              }}
            >
              <div
                className="w-full h-full bg-gradient-to-br from-zinc-800 to-zinc-900 rounded-lg border border-zinc-700"
                style={{
                  boxShadow: '0 4px 20px rgba(0, 0, 0, 0.6)',
                }}
              >
                {/* GPU shroud */}
                <div className="absolute inset-2 bg-zinc-700 rounded" />
                
                {/* GPU fans */}
                <div className="absolute inset-0 flex items-center justify-center gap-4 z-10">
                  <div className="w-8 h-8 border-2 border-zinc-500 rounded-full bg-zinc-800">
                    <div className="absolute inset-2 border border-zinc-600 rounded-full" />
                  </div>
                  <div className="w-8 h-8 border-2 border-zinc-500 rounded-full bg-zinc-800">
                    <div className="absolute inset-2 border border-zinc-600 rounded-full" />
                  </div>
                </div>
              </div>
            </div>
          )}

          {/* PSU - Realistic Style from Video */}
          {visibleComponents.includes('psu') && (
            <div
              className="absolute"
              style={{
                width: '85px',
                height: '65px',
                transform: visibleComponents.includes('case') 
                  ? 'translateZ(0px) translateX(-80px) translateY(50px)'
                  : 'translateZ(0px) translateX(200px) translateY(40px)',
              }}
            >
              <div
                className="w-full h-full bg-gradient-to-br from-zinc-900 to-black rounded border border-zinc-700"
                style={{
                  boxShadow: '0 4px 15px rgba(0, 0, 0, 0.5)',
                }}
              >
                {/* PSU fan grill */}
                <div className="absolute inset-4 border border-zinc-600 rounded-full flex items-center justify-center">
                  <div className="w-6 h-6 border border-zinc-500 rounded-full" />
                </div>
              </div>
            </div>
          )}

          {/* Case Fans - Realistic Style from Video */}
          {visibleComponents.includes('caseFans') && (
            <>
              {/* Front fan */}
              <div
                className="absolute"
                style={{
                  width: '45px',
                  height: '45px',
                  transform: visibleComponents.includes('case')
                    ? 'translateZ(5px) translateY(-90px)'
                    : 'translateZ(0px) translateX(-200px) translateY(-80px)',
                }}
              >
                <div
                  className="w-full h-full border-2 border-zinc-600 rounded-full bg-gradient-to-br from-zinc-700 to-zinc-800"
                  style={{
                    boxShadow: '0 2px 8px rgba(0, 0, 0, 0.3)',
                  }}
                >
                  {/* Fan hub */}
                  <div className="absolute inset-0 flex items-center justify-center">
                    <div className="w-7 h-7 border-2 border-zinc-500 rounded-full" />
                    <div className="absolute w-3 h-3 bg-zinc-600 rounded-full" />
                  </div>
                </div>
              </div>
              {/* Rear fan */}
              {visibleComponents.includes('case') && (
                <div
                  className="absolute"
                  style={{
                    width: '45px',
                    height: '45px',
                    transform: 'translateZ(5px) translateY(90px)',
                  }}
                >
                  <div
                    className="w-full h-full border-2 border-zinc-600 rounded-full bg-gradient-to-br from-zinc-700 to-zinc-800"
                    style={{
                      boxShadow: '0 2px 8px rgba(0, 0, 0, 0.3)',
                    }}
                  >
                    {/* Fan hub */}
                    <div className="absolute inset-0 flex items-center justify-center">
                      <div className="w-7 h-7 border-2 border-zinc-500 rounded-full" />
                      <div className="absolute w-3 h-3 bg-zinc-600 rounded-full" />
                    </div>
                  </div>
                </div>
              )}
            </>
          )}

          {/* Cables (shown as lines connecting components) */}
          {visibleComponents.includes('cables') && (
            <>
              {/* 24-pin motherboard cable */}
              <div
                className="absolute"
                style={{
                  width: '2px',
                  height: '60px',
                  transform: 'translateZ(5px) translateX(95px) translateY(-60px)',
                  background: 'linear-gradient(to bottom, #4a5568, #2d3748)',
                  boxShadow: '0 0 4px rgba(74, 85, 104, 0.5)',
                }}
              />
              {/* CPU power cable */}
              <div
                className="absolute"
                style={{
                  width: '2px',
                  height: '30px',
                  transform: 'translateZ(5px) translateX(-95px) translateY(-80px)',
                  background: 'linear-gradient(to bottom, #4a5568, #2d3748)',
                  boxShadow: '0 0 4px rgba(74, 85, 104, 0.5)',
                }}
              />
              {/* PCIe power cable to GPU */}
              <div
                className="absolute"
                style={{
                  width: '40px',
                  height: '2px',
                  transform: 'translateZ(22px) translateX(60px) translateY(-40px)',
                  background: 'linear-gradient(to right, #4a5568, #2d3748)',
                  boxShadow: '0 0 4px rgba(74, 85, 104, 0.5)',
                }}
              />
            </>
          )}
        </div>
      </div>

      {/* Instructions overlay */}
      <div className="absolute bottom-2 left-2 right-2 text-center">
        <p className="text-xs text-slate-400 bg-slate-900/70 backdrop-blur-sm px-3 py-1.5 rounded">
          Drag to rotate • Scroll to zoom • Step {currentStep}/10
        </p>
      </div>
    </div>
  )
}

