/*
 Part of the ReplicatorG project - http://www.replicat.org
 Copyright (c) 2008 Zach Smith

 Forked from Arduino: http://www.arduino.cc

 Based on Processing http://www.processing.org
 Copyright (c) 2004-05 Ben Fry and Casey Reas
 Copyright (c) 2001-04 Massachusetts Institute of Technology

 This program is free software; you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
 the Free Software Foundation; either version 2 of the License, or
 (at your option) any later version.

 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.

 You should have received a copy of the GNU General Public License
 along with this program; if not, write to the Free Software Foundation,
 Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */

package replicatorg.app.ui;

import java.awt.Color;
import java.awt.Dimension;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.Image;
import java.awt.Rectangle;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.image.BufferedImage;
import java.awt.image.RescaleOp;

import javax.swing.ImageIcon;
import javax.swing.JButton;
import javax.swing.JLabel;
import javax.swing.SwingUtilities;
import javax.swing.event.ChangeEvent;
import javax.swing.event.ChangeListener;

import net.miginfocom.swing.MigLayout;
import replicatorg.app.Base;
import replicatorg.drivers.SDCardCapture;
import replicatorg.machine.Machine;
import replicatorg.machine.MachineInterface;
import replicatorg.machine.MachineListener;
import replicatorg.machine.MachineProgressEvent;
import replicatorg.machine.MachineState;
import replicatorg.machine.MachineStateChangeEvent;
import replicatorg.machine.MachineToolStatusEvent;

/**
 * run/stop/etc buttons for the ide
 */
public class MainButtonPanel extends BGPanel implements MachineListener, ActionListener {

	/**
	 * This button is a special button type for the top bar. 
	 */
	class MainButton extends JButton implements ChangeListener {
		private String rolloverText; 
		public MainButton(String rolloverText,
				Image active,
				Image inactive,
				Image rollover,
				Image disabled) {
			this.rolloverText = rolloverText;
			setIcon(new ImageIcon(inactive));
			setSelectedIcon(new ImageIcon(active));
			setDisabledIcon(new ImageIcon(disabled));
			setRolloverEnabled(true);
			setRolloverIcon(new ImageIcon(rollover));
			setSize(new Dimension(active.getWidth(null),active.getHeight(null)));
			setBorder(null);
			getModel().addChangeListener(this);
			addActionListener(MainButtonPanel.this);
		}
		public String getRolloverText() { return rolloverText; }
		public void paint(Graphics g) {
			final Rectangle b = getBounds(); 
			if (getModel().isSelected()) {
				g.setColor(new Color(1.0f,1.0f,0.5f,0.8f));
				g.fillRect(0,0,b.width,b.height);
				getSelectedIcon().paintIcon(this,g,0,0);
			} else if (getModel().isEnabled()) {
				if (getModel().isPressed()) {
					g.setColor(new Color(1.0f,1.0f,0.5f,0.3f));
					g.fillRect(0,0,b.width,b.height);
					getSelectedIcon().paintIcon(this, g, 0, 0);
				} else if (getModel().isRollover()) {
					g.setColor(new Color(1.0f,1.0f,0.5f,0.3f));
					g.fillRect(0,0,b.width,b.height);
					getRolloverIcon().paintIcon(this, g, 0, 0);
				} else {
					g.setColor(BACK_COLOR);
					g.fillRect(0,0,b.width,b.height);
					getIcon().paintIcon(this,g,0,0);
				}
			} else {
				g.setColor(BACK_COLOR);
				g.fillRect(0,0,b.width,b.height);
				getDisabledIcon().paintIcon(this, g, 0, 0);
			}
		}
		public void stateChanged(ChangeEvent ce) {
			// It's possible to get a change event before the status label is initialized 
			if (statusLabel == null) return;
			if (getModel().isRollover()) {
				//statusLabel.setText(getRolloverText());
			} else {
				statusLabel.setText("");
			}
		}
	}
	
	
	// / height, width of the toolbar buttons
	static final int BUTTON_WIDTH = 53;
	static final int BUTTON_HEIGHT = 53;
	
	static final float disabledFactors[] = { 1.0f, 1.0f, 1.0f, 0.5f };
	static final float disabledOffsets[] = { 0.0f, 0.0f, 0.0f, 0.0f };
	static private RescaleOp disabledOp = new RescaleOp(disabledFactors,disabledOffsets,null);
	static final float activeFactors[] = { -1.0f, -1.0f, -1.0f, 1.0f };
	static final float activeOffsets[] = { 1.0f, 1.0f, 1.0f, 0.0f };
	static private RescaleOp activeOp = new RescaleOp(activeFactors,activeOffsets,null);


	

	// / amount of space between groups of buttons on the toolbar
	//static final int BUTTON_GAP = 5;

	MainWindow editor;

	Image offscreen;

	int maxLabelWidth;
	int width, height;

	Color bgcolor;

	JLabel statusLabel;
	
	//CHANGE COLOR HERE!
	final static Color BACK_COLOR = new Color(0x2D, 0xB6, 0xC7);
	MainButton spaceButton1,spaceButton2,spaceButton3,spaceButton4;
	MainButton simButton, pauseButton, stopButton;
	MainButton buildButton, resetButton, cpButton, rcButton;
	MainButton disconnectButton, connectButton, generateButton;
	
	MainButton uploadButton;//, playbackButton, fileButton;
	
	public MainButtonPanel(MainWindow editor) {
		setLayout(new MigLayout("gap 0, ins 0"));
		this.editor = editor;

		// hardcoding new blue color scheme for consistency with images,
		// see EditorStatus.java for details.
		// bgcolor = Preferences.getColor("buttons.bgcolor");
		setBackground(BACK_COLOR);

		Font statusFont = Base.getFontPref("buttons.status.font","SansSerif,plain,12");
		Color statusColor = Base.getColorPref("buttons.status.color","#EAEAEA");
		
		spaceButton1 = makeButton("spacer", "images/spacer.png","images/spacer.png","images/spacer.png","images/spacer.png");
		spaceButton2 = makeButton("spacer", "images/spacer2.png","images/spacer2.png","images/spacer2.png","images/spacer2.png");
		spaceButton3 = makeButton("spacer", "images/spacer2.png","images/spacer2.png","images/spacer2.png","images/spacer2.png");
		spaceButton4 = makeButton("spacer", "images/spacer2.png","images/spacer2.png","images/spacer2.png","images/spacer2.png");
		add(spaceButton1);
		
		buildButton = makeButton("Build", "images/build_active.png", "images/build_passive.png", "images/build_press.png","images/build_hover.png");
		add(buildButton);

		//playbackButton = makeButton("Build from SD card currently in printer", "images/button-playback.png");
		//add(playbackButton);
		//fileButton = makeButton("Build to file for use with SD card", "images/button-to-file.png");
		//add(fileButton);
		simButton = makeButton("Estimate time", "images/estimate_active.png", "images/estimate_passive.png", "images/estimate_press.png","images/estimate_hover.png");
		add(simButton);
		generateButton = makeButton("Model to GCode", "images/g_active.png", "images/g_passive.png", "images/g_press.png","images/g_hover.png");
		add(generateButton);
		add(spaceButton2);
		pauseButton = makeButton("Pause", "images/pause_active.png", "images/pause_passive.png", "images/pause_press.png","images/pause_hover.png");
		add(pauseButton);
		stopButton = makeButton("Stop", "images/stop_active.png", "images/stop_passive.png","images/stop_press.png","images/stop_hover.png");
		add(stopButton);
		add(spaceButton3);
		cpButton = makeButton("Control panel", "images/config_active.png", "images/config_passive.png", "images/config_press.png","images/config_hover.png");
		rcButton = makeButton("Live tuning", "images/tuning_active.png","images/tuning_passive.png","images/tuning_press.png","images/tuning_hover.png");
		add(cpButton);
		add(rcButton);
		add(spaceButton4);
		resetButton = makeButton("Reset machine", "images/reset_active.png", "images/reset_passive.png", "images/reset_press.png","images/reset_hover.png");
		add(resetButton);
		connectButton = makeButton("Connect", "images/power_press.png", "images/power_passive.png", "images/power_press.png","images/power.png");
		disconnectButton = makeButton("Disconnect", "images/power_active.png", "images/power_passive.png", "images/power_active.png","images/power_hover.png");
		add(connectButton);
		//add(disconnectButton);

		//statusLabel = new JLabel();
		//statusLabel.setFont(statusFont);
		//statusLabel.setForeground(statusColor);
		//add(statusLabel, "gap unrelated");

		//playbackButton.setToolTipText("This will build an object from an SD card currently inserted in the printer");
		//fileButton.setToolTipText("This will generate an .s3g file that can be put on an SD card and printed locally on the printer.");
		generateButton.setToolTipText("This will generate gcode for the currently open model.");
		buildButton.setToolTipText("This will start building the object on the machine.");
		pauseButton.setToolTipText("This will pause or resume the build.");
		stopButton.setToolTipText("This will abort the build in progress.");
		cpButton.setToolTipText("Here you'll find manual controls for the machine.");
		rcButton.setToolTipText("This can be used to tune the process, in real time, during a print job.");
		resetButton.setToolTipText("This will restart the firmware on the machine.");
		connectButton.setToolTipText("Connect to the machine.");
		disconnectButton.setToolTipText("Disconnect from the machine.");
		
		setPreferredSize(new Dimension(750,60));
		
		// Update initial state
		machineStateChangedInternal(new MachineStateChangeEvent(null, new MachineState(MachineState.State.NOT_ATTACHED)));
	}

	public MainButton makeButton(String rolloverText, String activeSrc, String inactiveSrc, String rolloverSrc, String hoverSrc) {
		
		BufferedImage img = Base.getImage(activeSrc, this);
		BufferedImage img_inactive = Base.getImage(inactiveSrc, this);
		BufferedImage img_rollover = Base.getImage(rolloverSrc, this);
		BufferedImage img_hover = Base.getImage(hoverSrc, this);
		if (img == null) {
			Base.logger.severe("Couldn't load button image: " + activeSrc
								+ ". Check that your path (" + System.getProperty("user.dir")
								+ ") contains this file");
			System.exit(1);
		}
		if (img_inactive == null) {
			Base.logger.severe("Couldn't load button image: " + inactiveSrc
								+ ". Check that your path (" + System.getProperty("user.dir")
								+ ") contains this file");
			System.exit(1);
		}
		if (img_rollover == null) {
			Base.logger.severe("Couldn't load button image: " + rolloverSrc
								+ ". Check that your path (" + System.getProperty("user.dir")
								+ ") contains this file");
			System.exit(1);
		}
		if (img_hover == null) {
			Base.logger.severe("Couldn't load button image: " + hoverSrc
								+ ". Check that your path (" + System.getProperty("user.dir")
								+ ") contains this file");
			System.exit(1);
		}
		BufferedImage disabled = img_inactive;
		Image inactive = img;
		Image rollover = img_hover;
		Image active = img_rollover;
		
		MainButton mb = new MainButton(rolloverText, active, inactive, rollover, disabled);
		mb.setEnabled(false);
		return mb;
	}
public MainButton makeButton(String rolloverText, String source) {
		
		BufferedImage img = Base.getImage(source, this);
		if (img == null) {
			Base.logger.severe("Couldn't load button image: " + source
								+ ". Check that your path (" + System.getProperty("user.dir")
								+ ") contains this file");
			System.exit(1);
		}

		BufferedImage disabled = disabledOp.filter(img,null);
		Image inactive = img;
		Image rollover = img;
		Image active = activeOp.filter(img,null);
		
		MainButton mb = new MainButton(rolloverText, active, inactive, rollover, disabled);
		mb.setEnabled(false);
		return mb;
	}

	public void actionPerformed(ActionEvent e) {
		if (e.getSource() == generateButton) {
			editor.runToolpathGenerator(false);
		} else if (e.getSource() == simButton){
			editor.handleSimulate();		
		} else if (e.getSource() == buildButton) {
			editor.handleBuild();
		} else if (e.getSource() == uploadButton) {
			editor.handleUpload();
		//} else if (e.getSource() == fileButton) {
		//	editor.handleBuildToFile();
		//} else if (e.getSource() == playbackButton) {
			//editor.handlePlayback();
		} else if (e.getSource() == pauseButton) {
			editor.handlePause();
		} else if (e.getSource() == stopButton) {
			editor.handleStop();
		} else if (e.getSource() == resetButton) {
			editor.handleReset();
		} else if (e.getSource() == cpButton) {
			editor.handleControlPanel();
		} else if (e.getSource() == connectButton) {
			editor.handleConnect();
		} else if (e.getSource() == disconnectButton) {
			editor.handleDisconnect(/*leavePreheatRunning=*/false, /*delete machine singleton*/false);
		} else if (e.getSource() == rcButton) {
			editor.handleRealTimeControl();
		}
	}

	public void machineStateChanged(MachineStateChangeEvent evt) {
		final MachineStateChangeEvent e = evt;
		SwingUtilities.invokeLater(new Runnable() {
			public void run() {
				machineStateChangedInternal(e);
			}
		});
	}
	
	/**
	 * Update the available and enabled buttons based on the latest machine state
	 */
	private void updateFromState(final MachineState s, final MachineInterface machine) {
		boolean connected = s.isConnected();
		boolean readyToPrint = s.canPrint();
		boolean configurable = s.isConfigurable();
		boolean building = s.isBuilding();
		boolean paused = s.isPaused();

		boolean hasMachine = machine != null;
		boolean hasPlayback = hasMachine && 
				(machine.getDriver() != null) &&
				(machine.getDriver() instanceof SDCardCapture) &&
				(((SDCardCapture)machine.getDriver()).hasFeatureSDCardCapture());
		boolean hasGcode = (editor != null) && (editor.getBuild() != null) &&
				editor.getBuild().getCode() != null;
		boolean hasModel = (editor != null) && (editor.getBuild() != null) &&
				editor.getBuild().getModel() != null;
		
		//fileButton.setEnabled(!building && hasGcode);
		simButton.setEnabled(hasGcode);
		buildButton.setEnabled(readyToPrint);
		generateButton.setEnabled(hasModel);
		//playbackButton.setEnabled(readyToPrint && hasPlayback);
		pauseButton.setEnabled(building && connected);
		stopButton.setEnabled(building);

		pauseButton.setSelected(paused);
		rcButton.setEnabled(building);

		Machine.JobTarget runningTarget = s.isBuilding()?machine.getTarget():null;
		
		buildButton.setSelected(runningTarget == Machine.JobTarget.MACHINE);
		//fileButton.setSelected(runningTarget == Machine.JobTarget.FILE);
		//playbackButton.setSelected(runningTarget == Machine.JobTarget.NONE);

		resetButton.setEnabled(connected); 
		if (connected && connectButton.isEnabled())
		{	
			
			remove(connectButton);
			//remove(statusLabel);
			add(disconnectButton);
			//add(statusLabel, "gap unrelated");
		}
		else if (!connected && disconnectButton.isEnabled())
		{

			remove(disconnectButton);
			//remove(statusLabel);
			add(connectButton);
			//add(statusLabel, "gap unrelated");
		}
		//disconnectButton.setVisible(connected);
		disconnectButton.setEnabled(connected);
		//connectButton.setVisible(!connected);
		connectButton.setEnabled(!connected);
		cpButton.setEnabled(configurable);
		rcButton.setVisible(editor.supportsRealTimeControl());
		
//		if (!editor.supportsRealTimeControl()) 
//		{
			// how to hide this button without taking up any space???
//			remove(rcButton);
//		} else {
			// FIXME: this changes the ordering of the buttons
//			add(rcButton);
//		}
	}

	public void updateFromMachine(final MachineInterface machine) {
		MachineState s = new MachineState(MachineState.State.NOT_ATTACHED);
		if (machine != null) {
			s = machine.getMachineState();
		}
		updateFromState(s,machine);
	}

	public void machineStateChangedInternal(final MachineStateChangeEvent evt) {
		MachineState s = evt.getState();
		MachineInterface machine = evt.getSource();
		updateFromState(s,machine);
	}

	public void machineProgress(MachineProgressEvent event) {
	}

	public void toolStatusChanged(MachineToolStatusEvent event) {
	}
}
